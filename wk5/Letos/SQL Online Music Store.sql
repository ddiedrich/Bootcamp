CREATE TABLE Artists (
    artist_id    INTEGER PRIMARY KEY,
    artist_name  TEXT,
    genre        TEXT,
    country      TEXT,
    active_since TEXT
);

CREATE TABLE Songs (
    song_id          INTEGER PRIMARY KEY,
    title            TEXT,
    artist_id        INTEGER REFERENCES Artists (artist_id),
    album            TEXT,
    release_date     TEXT,
    duration_seconds INTEGER,
    popularity_score INTEGER
);

CREATE TABLE Customers (
    customer_id    INTEGER PRIMARY KEY,
    first_name     TEXT,
    last_name      TEXT,
    email          TEXT,
    join_date      TEXT,
    premium_member INTEGER
);

CREATE TABLE Purchases (
    purchase_id   INTEGER PRIMARY KEY,
    customer_id   INTEGER REFERENCES Customers (customer_id),
    song_id       INTEGER REFERENCES Songs (song_id),
    purchase_date TEXT,
    price         REAL
);

CREATE TABLE Streams (
    stream_id   INTEGER PRIMARY KEY,
    customer_id INTEGER REFERENCES Customers (customer_id),
    song_id     INTEGER REFERENCES Songs (song_id),
    stream_date TEXT,
    stream_time TEXT
);

-- 1. Basic Selection: 

SELECT title, release_date FROM Songs
WHERE release_date >= 2022
AND release_date < 2023
ORDER BY release_date DESC;

-- 2. Filtering: 

SELECT title, popularity_score, duration_seconds
FROM Songs
WHERE popularity_score >= 80
AND duration_seconds < 240;

-- 3. Pattern Matching:

SELECT artist_name 
FROM Artists
WHERE artist_name LIKE 'The%';

-- 4. Multiple Conditions:

SELECT first_name, last_name, join_date, premium_member
FROM Customers 
WHERE join_date >=2022
AND join_date <2023;

-- 5. Calculations and Aliasing:

SELECT SUM(duration_seconds) / 60.0 AS total_duration_minutes
FROM Songs;

-- We haven't learned SUM yet
-- What about the whole database?

-- 6. Advanced Filtering:

SELECT song_id, price
FROM Purchases
ORDER BY price DESC
LIMIT 5;

SELECT Songs.title, Purchases.price
FROM Purchases
JOIN Songs
ON Purchases.song_id = Songs.song_id
ORDER BY Purchases.price DESC
LIMIT 5;

-- We haven't learned JOINs yet

-- 7. Using Multiple Tables Separately:

SELECT * 
FROM Purchases 
WHERE song_id 
IN 
(SELECT song_id
FROM Songs
WHERE popularity_score >=90);

-- This is a subquery - we haven't learned these yet

-- 8. Range Checking: 

SELECT * 
FROM Purchases 
WHERE purchase_date 
BETWEEN '2023-01-01' AND '2023-03-31';

-- 9. Advanced Filtering with ORDER BY:

SELECT title, popularity_score
FROM Songs 
WHERE popularity_score >= 90
ORDER BY popularity_score DESC;

-- 1. In our database design, we separated purchases and streams into different tables. 
-- 	What are the benefits of this approach versus having a single "user_interactions" table?

-- Answer: More details comparisons? I didn't use the 'Streams' table 

-- 2. Based on the provided data model, what business questions could music executives answer using SQL queries that we haven't covered in our exercise?

-- Answer: 

Which artist received the most song purchases? 

SELECT artist_name, COUNT(*) AS total_purchases
FROM Purchases
JOIN Songs ON Purchases.song_id = Songs.song_id
JOIN Artists ON Songs.artist_id = Artists.artist_id
GROUP BY Artists.artist_id, artist_name
ORDER BY total_purchases DESC
LIMIT 1;

What was the total price per year? 

SELECT strftime('%Y', purchase_date) AS year,
       SUM(price) AS total_price
FROM Purchases
GROUP BY year
ORDER BY total_price DESC

--3. How would you extend this schema to track more detailed user behavior, such as when users skip songs or how much of a song they listen to before skipping?

--Answer: I would include customer age and customer country 

--4. For tasks 1-3, how could you combine them into a single, more complex query that finds popular short songs by artists whose names start with "The"?

-- Answer: I would use a JOIN 



