Comments
-- In line comments (--)
In line comments --Hi(--)
/*Comments
from 
multiple 
rows 
*/

CREATE TABLE [Spotify Table] (
    track_name   TEXT,
    artist       TEXT,
    album        TEXT,
    release_date TEXT,
    popularity   INTEGER,
    spotify_url  TEXT,
    id           TEXT,
    duration     REAL
);

-- 1. Basic Selection

SELECT track_name,artist,popularity
FROM "Spotify Table"


SELECT track_name,artist,popularity
FROM "Spotify Table"
ORDER BY popularity DESC;

SELECT track_name,artist,popularity
FROM "Spotify Table"
ORDER BY popularity ASC;

--2. Column Aliases

SELECT track_name AS "Song Title", artist AS "Artist Name",popularity AS "Popularity Score"
FROM "Spotify Table"

SELECT track_name AS "Song Title",
       artist AS "Artist Name",
       popularity AS "Popularity Score"
FROM "Spotify Table"

-- 3. Filtering with WHERE

SELECT track_name, popularity FROM "Spotify Table" WHERE popularity >=90
SELECT popularity FROM "Spotify Table" WHERE popularity >=90

--I wasn't able to use the alias from above for additional queries to reference

-- 4. Multiple Conditions:

SELECT track_name, artist, popularity 
FROM "Spotify Table" 
WHERE artist = 'The Weeknd' AND popularity >= 85
OR artist ='Drake' AND popularity >=85;

SELECT track_name, artist, popularity 
FROM "Spotify Table" 
WHERE artist IN ('The Weeknd', 'Drake')
AND popularity >= 85;

SELECT track_name, album, popularity
FROM "Spotify Table" 
WHERE album IN ('Starboy','1989')
AND popularity >= 70

-- 5. Pattern Matching:

Select artist, track_name
FROM "Spotify Table"
WHERE track_name LIKE '%Love%';

--6. Range Checking:

SELECT track_name, duration
FROM "Spotify Table" 
WHERE duration BETWEEN 3 AND 4;

SELECT track_name, release_date
FROM "Spotify Table"
WHERE release_date 
BETWEEN 2020 AND 'Today';

-- Does Today work as an operator like in Excel? Use CURRENT DATE

SELECT track_name, release_date
FROM "Spotify Table"
WHERE release_date 
BETWEEN 2020-01 AND 2022-12;

--(That didn't work)

-- 7. Sorting Results:

See example above for popularity DESC

SELECT artist
FROM "Spotify Table"
ORDER BY artist ASC;

-- 8. Multiple Column Sorting:

SELECT artist, popularity
FROM "Spotify Table"
ORDER BY artist ASC,popularity DESC;

-- 9. Combining WHERE and ORDER BY:

SELECT track_name, release_date, popularity
FROM "Spotify Table"
WHERE release_date >= 2020
AND release_date < 2021
ORDER BY popularity DESC;

SELECT track_name, release_date, popularity
FROM "Spotify Table"
WHERE release_date >= '2020-01-01'
AND release_date < '2021-01-01'
ORDER BY popularity DESC;

-- 10. Comprehensive Query:

SELECT track_name, artist, duration
FROM "Spotify Table"
WHERE duration = 4
AND artist LIKE 'A%'
ORDER BY artist ASC, duration DESC;






