CREATE TABLE Branches (
    branch_id   INTEGER PRIMARY KEY,
    branch_name TEXT,
    address     TEXT,
    city        TEXT,
    phone       TEXT
);

CREATE TABLE Patrons (
    patron_id         INTEGER PRIMARY KEY,
    first_name        TEXT,
    last_name         TEXT,
    email             TEXT,
    address           TEXT,
    city              TEXT,
    registration_date TEXT,
    branch_id         INTEGER REFERENCES Branches (branch_id) 
);

CREATE TABLE Genres (
    genre_id    INTEGER PRIMARY KEY,
    genre_name  TEXT,
    description TEXT
);

CREATE TABLE Authors (
    author_id  INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name  TEXT,
    birth_year INTEGER,
    country    TEXT
);

CREATE TABLE Books (
    book_id          INTEGER PRIMARY KEY,
    title            TEXT,
    author_id        INTEGER REFERENCES Authors (author_id),
    genre_id         INTEGER REFERENCES Genres (genre_id),
    isbn             TEXT,
    publication_year INTEGER,
    copies_owned     INTEGER
);

ALTER TABLE Books
RENAME COLUMN isbn TO ISBN;

CREATE TABLE Loans (
    loan_id       INTEGER PRIMARY KEY,
    book_id       INTEGER REFERENCES Books (book_id),
    patron_id     INTEGER REFERENCES Patrons (patron_id),
    branch_id     INTEGER REFERENCES Branches (branch_id),
    checkout_date TEXT,
    due_date      TEXT,
    return_date   TEXT
);

-- 1. Basic Selection

SELECT title, publication_year
FROM Books
WHERE publication_year >= '2000'
ORDER BY publication_year DESC;

-- 2. Filtering:

SELECT Books.title, Genres.genre_name, Books.copies_owned
FROM Books
INNER JOIN Genres
ON Books.genre_id = Genres.genre_id
WHERE copies_owned >= 5 AND genre_name = 'Fiction'
ORDER BY title ASC;

-- 3. Pattern Matching:

SELECT title 
FROM Books 
WHERE title LIKE '%History%';

-- 4. JOIN Operations: 

SELECT Loans.loan_id, Loans.checkout_date, Loans.due_date, Patrons.first_name, Patrons.last_name, Patrons.email
FROM Loans
INNER JOIN Patrons
ON Loans.patron_id = Patrons.patron_id
WHERE Loans.checkout_date >= '2023-01-01'
AND Loans.checkout_date < '2023-02-01';

-- 5. Multi-table JOIN:

SELECT Books.title, Authors.first_name ||' '|| Authors.last_name AS 'authors_full_name', Genres.genre_name, Loans.loan_id, Loans.checkout_date, Loans.due_date
FROM Loans
INNER JOIN Books
ON Books.book_id = Loans.book_id
INNER JOIN Authors
ON Authors.Author_ID = Books.author_id
INNER JOIN Genres
ON Books.genre_id = Genres.genre_id;

-- 6. Self JOIN: 

SELECT Patron1.first_name || ' ' || Patron1.last_name AS patron_1,
       Patron2.first_name || ' ' || Patron2.last_name AS patron_2,
       Patron1.city
FROM Patrons AS Patron1
JOIN Patrons AS Patron2
ON Patron1.city = Patron2.city
AND Patron1.patron_id < Patron2.patron_id
ORDER BY Patron1.city;

--7. Multi-table JOIN with filtering:

SELECT Books.title, Patrons.first_name || ' ' || Patrons.last_name AS patron_name, Branches.branch_name, Genres.genre_name -- with genre_name
 FROM Loans
 INNER JOIN Books
 ON Loans.book_id = Books.book_id
 INNER JOIN Patrons
 ON Loans.patron_id = Patrons.patron_id
 INNER JOIN Branches
 ON Loans.branch_id = Branches.branch_id
 INNER JOIN Genres
 ON Books.genre_id = Genres.genre_id
 WHERE genre_name = 'Fiction'
 ORDER BY Books.title ASC;

 SELECT Books.title, Patrons.first_name || ' ' || Patrons.last_name AS patron_name, Branches.branch_name -- without genre_name
 FROM Loans
 INNER JOIN Books
 ON Loans.book_id = Books.book_id
 INNER JOIN Patrons
 ON Loans.patron_id = Patrons.patron_id
 INNER JOIN Branches
 ON Loans.branch_id = Branches.branch_id
 INNER JOIN Genres
 ON Books.genre_id = Genres.genre_id
 WHERE genre_name = 'Fiction'
 ORDER BY Books.title ASC;

-- 8. COUNT aggregation

SELECT Genres.genre_name AS "Genre Name", COUNT (Books.book_id) AS "Number of Books"
FROM Genres
INNER JOIN Books
ON Books.genre_id = Genres.genre_id
GROUP BY Genres.genre_id, Genres.genre_name
ORDER BY "Number of Books" Desc;

-- Multiple aggregations:

-- This didn't work because you can't subtract dates that are text

SELECT AVG(checkout_date - return_date) AS "Average Loan Duration",
MIN(checkout_date - return_date) AS "Minimum Loan Duration",
MAX(checkout_date - return_date) AS "Maximum Loan Duration", branch_id
FROM Loans
WHERE Loans.return_date IS NOT NULL OR Loans.return_date != ''
ORDER BY branch_id;

SELECT Branches.branch_name,
ROUND(AVG(julianday(Loans.return_date) - julianday(Loans.checkout_date)), 1) AS avg_loan_days,
MIN(julianday(Loans.return_date) - julianday(Loans.checkout_date)) AS min_loan_days,
MAX(julianday(Loans.return_date) - julianday(Loans.checkout_date)) AS max_loan_days
FROM Loans
INNER JOIN Branches ON Loans.branch_id = Branches.branch_id
WHERE Loans.return_date IS NOT NULL OR Loans.return_date != ''
GROUP BY Branches.branch_name;

-- The 0 rounds up to the next whole number...no decimals
SELECT Branches.branch_name,
ROUND(AVG(julianday(Loans.return_date) - julianday(Loans.checkout_date)), 0) AS avg_loan_days,
MIN(julianday(Loans.return_date) - julianday(Loans.checkout_date)) AS min_loan_days,
MAX(julianday(Loans.return_date) - julianday(Loans.checkout_date)) AS max_loan_days
FROM Loans
INNER JOIN Branches ON Loans.branch_id = Branches.branch_id
WHERE Loans.return_date IS NOT NULL OR Loans.return_date != ''
GROUP BY Branches.branch_name;

-- Conditional aggregation: 













