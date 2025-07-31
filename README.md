# MusicStoreDb_Analysis
## Overview
This project analyzes the music store dataset, using PostgreSQL. It uncovers key business insights like top customers, popular music genres, best-selling artists, and customer preferences across countries.
## Key Concepts Covered
### 1. Database Normalization
The database is normalized to Third Normal Form (3NF), which avoids redundancy and ensures data integrity. This structure allows efficient storage and accurate querying, though it can require complex joins for real-world insights.

### 2. Relational Data Analysis
We leveraged relational algebra through SQL to connect data from multiple tables using JOIN operations and analyzed it using:
Aggregation: SUM, AVG, COUNT
Filtering: WHERE, HAVING
Sorting & Ranking: ORDER BY, ROW_NUMBER()
Grouping: GROUP BY

### 3. Window Functions
We used window functions like ROW_NUMBER() and RANK() to partition and rank rows based on conditions. This is especially useful when:
Identifying the top customer per country
Finding the most popular genre in each region

### 4. Common Table Expressions (CTEs)
CTEs (WITH clause) improve readability, modularity, and debugging of SQL queries. They are especially useful when breaking down complex logic like:
Finding the best-selling artist
Comparing customer spending across multiple conditions
