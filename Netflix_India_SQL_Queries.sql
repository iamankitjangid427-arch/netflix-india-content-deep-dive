-- ==========================================
-- Netflix India Content Deep Dive
-- Author : Ankit Jangid
-- ==========================================

-- Analysis 1
SELECT COUNT(*) AS Total_Indian_Titles
FROM netflix_titles
WHERE country LIKE '%India%';

-- Analysis 2
SELECT
    type,
    COUNT(*) AS Total_Titles
FROM netflix_titles
WHERE country LIKE '%India%'
GROUP BY type;

-- Analysis 3
SELECT
    YEAR(STR_TO_DATE(TRIM(date_added), '%M %d, %Y')) AS year_added,
    type,
    COUNT(*) AS Total_Titles
FROM netflix_titles
WHERE country LIKE '%India%'
AND date_added IS NOT NULL
GROUP BY year_added, type
ORDER BY year_added;

...
SELECT *
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Indian_Titles.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM netflix_titles
WHERE country LIKE '%India%';

mysql> CREATE DATABASE netflix_india_db;
Query OK, 1 row affected (0.07 sec)

mysql> USE netflix_india_db;
Database changed
mysql> CREATE TABLE netflix_titles (
    ->     show_id VARCHAR(20),
    ->     type VARCHAR(20),
    ->     title VARCHAR(255),
    ->     director TEXT,
    ->     cast TEXT,
    ->     country TEXT,
    ->     date_added VARCHAR(50),
    ->     release_year INT,
    ->     rating VARCHAR(20),
    ->     duration VARCHAR(30),
    ->     listed_in TEXT,
    ->     description TEXT
    -> );
Query OK, 0 rows affected (0.14 sec)

mysql> DESCRIBE netflix_titles;
+--------------+--------------+------+-----+---------+-------+
| Field        | Type         | Null | Key | Default | Extra |
+--------------+--------------+------+-----+---------+-------+
| show_id      | varchar(20)  | YES  |     | NULL    |       |
| type         | varchar(20)  | YES  |     | NULL    |       |
| title        | varchar(255) | YES  |     | NULL    |       |
| director     | text         | YES  |     | NULL    |       |
| cast         | text         | YES  |     | NULL    |       |
| country      | text         | YES  |     | NULL    |       |
| date_added   | varchar(50)  | YES  |     | NULL    |       |
| release_year | int          | YES  |     | NULL    |       |
| rating       | varchar(20)  | YES  |     | NULL    |       |
| duration     | varchar(30)  | YES  |     | NULL    |       |
| listed_in    | text         | YES  |     | NULL    |       |
| description  | text         | YES  |     | NULL    |       |
+--------------+--------------+------+-----+---------+-------+
12 rows in set (0.06 sec)

mysql> C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\
ERROR:
Unknown command '\P'.
ERROR:
Unknown command '\M'.
ERROR:
Unknown command '\M'.
ERROR:
Unknown command '\U'.
    -> SHOW VARIABLES LIKE 'secure_file_priv';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads
SHOW VARIABLES LIKE 'secure_file_p' at line 1
mysql> SHOW VARIABLES LIKE 'secure_file_priv';
+------------------+------------------------------------------------+
| Variable_name    | Value                                          |
+------------------+------------------------------------------------+
| secure_file_priv | C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\ |
+------------------+------------------------------------------------+
1 row in set (0.16 sec)

mysql> LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_titles.csv'
    -> INTO TABLE netflix_titles
    -> FIELDS TERMINATED BY ','
    -> ENCLOSED BY '"'
    -> LINES TERMINATED BY '\n'
    -> IGNORE 1 ROWS;
Query OK, 8807 rows affected (0.30 sec)
Records: 8807  Deleted: 0  Skipped: 0  Warnings: 0

mysql> SELECT COUNT(*) AS Total_Records
    -> FROM netflix_titles;
+---------------+
| Total_Records |
+---------------+
|          8807 |
+---------------+
1 row in set (0.05 sec)

mysql> SELECT COUNT(*) AS Total_Indian_Titles
    -> FROM netflix_titles
    -> WHERE country LIKE '%India%';
+---------------------+
| Total_Indian_Titles |
+---------------------+
|                1046 |
+---------------------+
1 row in set (0.01 sec)

mysql> SELECT COUNT(*) AS Total_Indian_Titles
    -> FROM netflix_titles
    -> WHERE country LIKE '%India%';
+---------------------+
| Total_Indian_Titles |
+---------------------+
|                1046 |
+---------------------+
1 row in set (0.01 sec)

mysql> SELECT
    ->     type,
    ->     COUNT(*) AS Total_Titles
    -> FROM netflix_titles
    -> WHERE country LIKE '%India%'
    -> GROUP BY type;
+---------+--------------+
| type    | Total_Titles |
+---------+--------------+
| TV Show |           84 |
| Movie   |          962 |
+---------+--------------+
2 rows in set (0.02 sec)

mysql> SELECT
    ->     type,
    ->     COUNT(*) AS Total_Titles
    -> FROM netflix_titles
    -> WHERE country LIKE '%India%'
    -> GROUP BY type;
+---------+--------------+
| type    | Total_Titles |
+---------+--------------+
| TV Show |           84 |
| Movie   |          962 |
+---------+--------------+
2 rows in set (0.01 sec)

mysql> SELECT
    ->     YEAR(STR_TO_DATE(TRIM(date_added), '%M %d, %Y')) AS year_added,
    ->     type,
    ->     COUNT(*) AS Total_Titles
    -> FROM netflix_titles
    -> WHERE country LIKE '%India%'
    -> AND date_added IS NOT NULL
    -> GROUP BY year_added, type
    -> ORDER BY year_added;
+------------+---------+--------------+
| year_added | type    | Total_Titles |
+------------+---------+--------------+
|       2016 | Movie   |           13 |
|       2017 | Movie   |          148 |
|       2017 | TV Show |           14 |
|       2018 | Movie   |          332 |
|       2018 | TV Show |           17 |
|       2019 | Movie   |          200 |
|       2019 | TV Show |           18 |
|       2020 | Movie   |          181 |
|       2020 | TV Show |           18 |
|       2021 | Movie   |           88 |
|       2021 | TV Show |           17 |
+------------+---------+--------------+
11 rows in set (0.02 sec)

mysql> SELECT
    ->     director,
    ->     COUNT(*) AS Total_Titles
    -> FROM netflix_titles
    -> WHERE country LIKE '%India%'
    -> AND director IS NOT NULL
    -> GROUP BY director
    -> ORDER BY Total_Titles DESC
    -> LIMIT 10;
+--------------------+--------------+
| director           | Total_Titles |
+--------------------+--------------+
|                    |           85 |
| David Dhawan       |            9 |
| Ram Gopal Varma    |            7 |
| Ashutosh Gowariker |            6 |
| Imtiaz Ali         |            6 |
| Anees Bazmee       |            6 |
| Rajkumar Santoshi  |            6 |
| Sooraj R. Barjatya |            6 |
| Rajiv Mehra        |            5 |
| Mahesh Manjrekar   |            5 |
+--------------------+--------------+
10 rows in set (0.01 sec)

mysql> SELECT
    ->     director,
    ->     COUNT(*) AS Total_Titles
    -> FROM netflix_titles
    -> WHERE country LIKE '%India%'
    -> AND director IS NOT NULL
    -> AND TRIM(director) <> ''
    -> GROUP BY director
    -> ORDER BY Total_Titles DESC
    -> LIMIT 10;
+--------------------+--------------+
| director           | Total_Titles |
+--------------------+--------------+
| David Dhawan       |            9 |
| Ram Gopal Varma    |            7 |
| Anees Bazmee       |            6 |
| Imtiaz Ali         |            6 |
| Sooraj R. Barjatya |            6 |
| Rajkumar Santoshi  |            6 |
| Ashutosh Gowariker |            6 |
| Rohit Shetty       |            5 |
| Anurag Kashyap     |            5 |
| Madhur Bhandarkar  |            5 |
+--------------------+--------------+
10 rows in set (0.01 sec)

mysql> TRIM(director) <> ''
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'TRIM(director) <> ''' at line 1
mysql> SELECT
    ->     listed_in,
    ->     COUNT(*) AS Total_Titles
    -> FROM netflix_titles
    -> WHERE country LIKE '%India%'
    -> GROUP BY listed_in
    -> ORDER BY Total_Titles DESC
    -> LIMIT 10;
+--------------------------------------------------+--------------+
| listed_in                                        | Total_Titles |
+--------------------------------------------------+--------------+
| Comedies, Dramas, International Movies           |          124 |
| Dramas, International Movies                     |          123 |
| Dramas, Independent Movies, International Movies |          121 |
| Dramas, International Movies, Romantic Movies    |           64 |
| Action & Adventure, Dramas, International Movies |           55 |
| Dramas, International Movies, Thrillers          |           44 |
| Comedies, International Movies, Romantic Movies  |           42 |
| Dramas, International Movies, Music & Musicals   |           39 |
| Comedies, International Movies, Music & Musicals |           35 |
| Comedies, Dramas, Independent Movies             |           28 |
+--------------------------------------------------+--------------+
10 rows in set (0.01 sec)

mysql> WITH RECURSIVE genre_split AS (
    ->     SELECT
    ->         TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
    ->         SUBSTRING(listed_in,
    ->                   LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2) AS remaining
    ->     FROM netflix_titles
    ->     WHERE country LIKE '%India%'
    ->
    ->     UNION ALL
    ->
    ->     SELECT
    ->         TRIM(SUBSTRING_INDEX(remaining, ',', 1)),
    ->         CASE
    ->             WHEN remaining LIKE '%,%'
    ->             THEN SUBSTRING(remaining,
    ->                  LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2)
    ->             ELSE ''
    ->         END
    ->     FROM genre_split
    ->     WHERE remaining <> ''
    -> )
    ->
    -> SELECT
    ->     genre,
    ->     COUNT(*) AS Total_Titles
    -> FROM genre_split
    -> WHERE genre <> ''
    -> GROUP BY genre
    -> ORDER BY Total_Titles DESC
    -> LIMIT 10;
+------------------------+--------------+
| genre                  | Total_Titles |
+------------------------+--------------+
| International Movies   |          864 |
| Dramas                 |          662 |
| Comedies               |          323 |
| Independent Movies     |          167 |
| Action & Adventure     |          137 |
| Romantic Movies        |          120 |
| Music & Musicals       |           96 |
| Thrillers              |           92 |
| International TV Shows |           66 |
| Horror Movies          |           35 |
+------------------------+--------------+
10 rows in set (0.04 sec)

mysql> SELECT
    ->     rating,
    ->     COUNT(*) AS Total_Titles
    -> FROM netflix_titles
    -> WHERE country LIKE '%India%'
    -> AND rating IS NOT NULL
    -> AND TRIM(rating) <> ''
    -> GROUP BY rating
    -> ORDER BY Total_Titles DESC;
+----------+--------------+
| rating   | Total_Titles |
+----------+--------------+
| TV-14    |          572 |
| TV-MA    |          266 |
| TV-PG    |          144 |
| TV-Y7    |           17 |
| PG-13    |           11 |
| TV-G     |           10 |
| PG       |            7 |
| NR       |            7 |
| TV-Y     |            6 |
| R        |            5 |
| TV-Y7-FV |            1 |
+----------+--------------+
11 rows in set (0.01 sec)