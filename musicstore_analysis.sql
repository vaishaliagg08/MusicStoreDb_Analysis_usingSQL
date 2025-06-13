-- who is the senior most employee based on job title ?

select * from employee 
ORDER BY levels desc 
limit 1

-- which country has the most invoices ?

select COUNT(*) as c, billing_country
from invoice
Group by billing_country
order by c desc
limit 1

-- top 3 values of total invoices ?

select total from invoice 
order by total desc
limit 3 

-- which city has the best customer?
-- we would like to throw a promotional music festival in the city 
-- we made the most money .write a query that returns one city 
-- that has a highest sum of invoices total.
-- return both the city name and sum of all invoices 

select SUM(total) as invoice_total,billing_city
from invoice 
group by billing_city 
order by invoice_total desc
limit 1

-- who is the best customer?
-- the customer who has spent the most money will be declared the best customer 
-- so write query that returns the person who has spend the most money

select customer.customer_id, customer.first_name, customer.last_name, 
SUM(invoice.total)as total  
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id 
order by total desc 
limit 1

-- write query to return the email, first name, last name and genre of all rock music listner. 
-- return your list oredered alphabatically by email starting with A

select distinct email, first_name, last_name from customer 
join invoice on customer.customer_id = invoice.customer_id 
join invoice_line on invoice.invoice_id = invoice_line.invoice_id 
where track_id in(
      select track_id from track
      join genre on track.genre_id = genre.genre_id
	  where genre.name like 'Rock' 
	  )
order by email;

-- lets invite an artist who have written the most rock music in our data set. 
-- write a query that returns the artist name and 
-- total track count of he top 10 rock band 

select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs 
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
group by artist.artist_id 
order by number_of_songs desc 
limit 10 

-- return all the track name that have a song length longer than a average song length 
-- return name and milliseconds of each track order by the song length with the 
-- longest song listed first 

select name, milliseconds 
from track 
where milliseconds >(
       select avg(milliseconds) as avg_track_length
	   from track)
order by milliseconds desc;


-- find how much amount spent by each customeron artist?
-- write a query to return a customer name, artist name and total spent 

with best_selling_artist as(
     select artist.artist_id as artist_id, artist.name as artist_name, sum(invoice_line.unit_price*invoice_line.quantity) 
	 as amount_spent 
	 from invoice_line
	 join track on track.track_id = invoice_line.track_id
	 join album on album.album_id = track.album_id
	 join artist on artist.artist_id = album.artist_id
	 group by 1
	 order by 3 desc 
	 limit 1	 
)

select c.customer_id, c.first_name, c.last_name, bsa.artist_name, sum(il.unit_price*il.quantity) as amount_spent
from invoice i 
join customer c on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join album alb on alb.album_id = t.album_id
join best_selling_artist bsa on bsa.artist_id = alb.artist_id
group by 1,2,3,4
order by 5 desc

-- we want to find the most popular music genre in each country 
-- we determine the most popular genre as the genrewith the highest amount of purchases 
-- write a query that returns a each countryalong with the top genre 
-- for countries where maximum number of purchases is shared return all genres .

with popular_genre as 
(
   select count(invoice_line.quantity) as purchases, customer.country, genre.name, genre.genre_id,
   row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as RowNo
   from invoice_line
   join invoice on invoice.invoice_id = invoice_line.invoice_id
   join customer on customer.customer_id = invoice.customer_id 
   join track on track.track_id = invoice_line.track_id
   join genre on genre.genre_id = track.genre_id 
   group by 2,3,4
   order by 2 asc , 1 desc 
)

select * from popular_genre where RowNo <= 1

-- write a query that determines the customer that has spent the most on music for each country 
-- write a query that returns the country along with the top customer and how much they spent 
-- for countries where top amount spend is shared provide all customer who spend this amount 

with Customer_with_country as(
     select customer.customer_id, first_name , last_name, billing_country, SUM(total) as total_spending,
	 Row_number() over(partition by billing_country order by sum(total)desc) as RowNo
	 from invoice
	 join customer on customer.customer_id = invoice.customer_id 
	 group by 1,2,3,4
	 order by 4 asc, 5 desc)

select * from Customer_with_country where RowNo <=1









   



