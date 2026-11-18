-- Documentation and Insight Reporting

-- Table Schema ---

CREATE TABLE [Movie Analysis] (
    [IMBD title ID] TEXT    PRIMARY KEY
                            UNIQUE,
    Title           TEXT,
    [Release Date]  TEXT,
    Year            INTEGER,
    Genre_1         TEXT,
    Genre_2         TEXT,
    Genre_3         TEXT,
    Duration        INTEGER,
    Country         TEXT,
    Content_Rating  TEXT,
    Director        TEXT,
    Income          NUMERIC,
    Votes           INTEGER,
    Score           REAL
);

-- Exploratory Query Analysis ---

-- MIN/MAX
-- Summary: Query to find the movie with the lowest income

SELECT Title, MIN("Income")
FROM "Movie Analysis"

-- 12 Angry Men, 576

-- Grouping with SUM/AVG (Review CASE WHEN at a later time)
-- Summary: Query to find the average income in each score block and a correlation between income and score.

SELECT CASE
	WHEN Score BETWEEN 9.0 AND 10.0 THEN '9.0 - 10.0'
	WHEN Score BETWEEN 8.0 AND 8.9 THEN '8.0 - 8.9'
	WHEN Score BETWEEN 7.0 AND 7.9 THEN '7.0 - 7.9'
  END AS "Score Group", AVG(Income) AS "Avg Income"
FROM "Movie Analysis"
GROUP BY CASE
    WHEN Score BETWEEN 9.0 AND 10.0 THEN '9.0 - 10.'
    WHEN Score BETWEEN 8.0 AND 8.9 THEN '8.0 - 8.9'
    WHEN Score BETWEEN 7.0 AND 7.9 THEN '7.0 - 7.9'
   END
ORDER BY "Score Group" DESC;

-- Score Group | AvG Income
-- 	9.0 - 10.0| 422106803.25
--	8.0 - 8.9 | 359018682.088235

-- Date-based filtering
-- Summary: Query to find how many movies were produced each year. Which years produced the most movies and which years the least? 

SELECT Year, COUNT('IMBD title ID') AS 'Movie Count'
FROM 'Movie Analysis'
GROUP BY Year
ORDER BY Year DESC;

-- Year | Movie Count
-- 2019 | 4
-- 2018 | 2

-- Summary: Date query to group all movies into two categories (Before & After the MPAA Rating System) and the movie count per category

SELECT CASE
	WHEN Year < 1968 THEN 'Before the MPAA Rating System'
	ELSE 'After the MPAA Rating System'
	END AS "Era", COUNT("IMBD title ID") AS "Movie Count"
FROM "Movie Analysis"
GROUP BY "Era";

-- Era  | Movie COUNT
-- After the MPAA Rating System  | 83
-- Before the MPAA Rating System | 17

-- Text pattern matching using LIKE 
-- Summary: Query looked for all distinct directors named Chris (to include Christopher, Christian, Chris, etc.)

SELECT DISTINCT Director 
FROM 'Movie Analysis' 
WHERE Director LIKE 'Chris%';
 
-- Director
-- Christopher Nolan

-- Business Query Analysis ---

-- Ranking and percentiles
-- Summary: This query ranks movies by income and returns the top 5. This is the same analysis as in my pivot table and chart. 

SELECT Title, Income 
FROM 'Movie Analysis' 
ORDER BY Income DESC
LIMIT 5 

-- Title | Income
-- Avengers: Endgame | 2797800564
-- Avengers: Infinity War | 2048359754
-- The Lord of the Rings: The Return of the King | 1142271098
-- The Dark Knight Rises | 1081133191
-- Jokerm | 1074251311

-- Summary: This query looks at movie count, average income and average score by year. It also rounds up the average income and score to one decimal place.

SELECT Year, COUNT("IMBD title ID") AS "Movie Count",
    ROUND (AVG(Income),1) AS "Avg Income",
    ROUND (AVG(Score),1) AS "Avg Score"
FROM "Movie Analysis"
GROUP BY Year
ORDER BY Year ASC;

-- Year | Movie Count | Avg Income | Avg Score
-- 1936	| 1	| 457688 | 8.3
-- 1940	| 1	| 969879 | 8
-- 1941	| 1 | 1594107| 7.6

-- Cohort analysis (grouping related records)
-- Summary: This query looks the movie count, average income and average score (rounded up) and assigns the revelent decade to all years.
 
SELECT (Year / 10) * 10 AS "Decade", -- only possible when year is an integer
     COUNT("IMBD title ID") AS "Movie Count",
     ROUND (AVG(Income), 1) AS "Avg Income",
     ROUND (AVG(Score), 1) AS "Avg Score"
FROM "Movie Analysis"
GROUP BY "Decade"
ORDER BY "Decade" ASC;

-- Decade | Movie Count | Avg Income | Avg Score
-- 1930	| 1	| 457688	| 8.3
-- 1940	| 4	| 3267366.8	| 8.1
-- 1950 | 7	| 6769863.6	| 8

-- Running totals or moving averages
-- Summary: This query shows year and that year's income along with a running total that adds the cumulative income of all rows above it.

SELECT Year,
       SUM(Income) AS "Yearly Income",
       SUM(SUM(Income)) OVER (ORDER BY Year) AS "Cumulative Income" -- use OVER w/ ORDER BY
FROM "Movie Analysis"
GROUP BY Year
ORDER BY Year;

-- Year | Yearly Income | Cumulative Income
-- 1936	| 457688 | 457688
-- 1940 | 969879 | 1427567
-- 1941	| 1594107 | 3021674

-- Top significant insights discovered --

-- 12 Angry Men was a flop - little return on investment
-- Movies with higher incomes also score higher
-- The year with the most movies produced was 2019
-- Most movies on the list were made after 1968, but if content ratings are important, fiter out the 17 that were made before 1968.
-- Christopher Nolan is the only director with "Chris" in his name
-- Seeing the top 5 highest earning films confirms my earlier analysis
-- Having all Year | Movie Count | Avg Income | Avg Score together gives me a more comprehensive view of the data 
-- Assigning individual years to the decade that it belongs to gives me a higher level view of the last query 
-- Showing the cumlative income can helpful for financial analysis

-- Paragraph explanation of how these insights could inform business decisions ---

-- By running these and similar queries, movie producers can make data-driven decisions when pursuing their goal of making high earning movies. 

-- Which director should they pick? They can see directors who made multiple movies, and who made just one movie.
-- What made 2019 so special for movies? Can they reproduce it?
-- They can do a deeper dive into reasons. Were there tax breaks that year for the industry? Were films marketed differently?
-- Which genres are the most popular? (This one is worked out on my Notes) 
-- Drama, Adventure, Crime, and Action are the most common genres, so if unsure about which type of genre to produce, stick with one of them.
-- Cumulative income can show trends and help with future forecasting.

-- Data Analysis Report --- 

-- Dataset Introduction:
-- Source of data: Kaggle
-- Size (number of tables and approximate records): 1 table, 100 records / rows
-- General subject matter (e.g., "retail sales data," "healthcare patient records"): Movie earnings and ratings 

-- Analysis Objectives:
-- Business questions being investigated: What factors contribute to high earning movies? 
-- Patterns or trends the analysis hopes to uncover: Favorable genres, countries, release year, etc. 
-- Specific hypotheses being tested with the data: Recent action or adventure movies brought in some of the highest income and scores.

-- Analytical Approach and Findings:
-- Brief overview of methods used: SELECT, MIN, CASE WHEN/ELSE, GROUP BY, ORDER BY, DISTINCT, LIMIT, OVER, SUM, AS, ROUND, DESC/ASC
-- Query explanations and insights: Comparisons of release years, genres, scores, and other attributes that impacted changes in earnings or popularity 

-- Business Recommendations:
-- Strategic suggestions based on your complete analysis: Run additional queries to see if duration impacts earnings. Make sure data is correct at the time of collection.
-- Actionable insights for stakeholders derived from your findings: Target action or adventure movies-goers. These movies have the highest earning potential. 
