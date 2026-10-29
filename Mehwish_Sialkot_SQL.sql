/* ============================================================
   SQL Practice: 4 Tasks on Sialkot Wedding Venues
   Name: Mehwish Noreen
   Data: 20 venues from Google Maps, captured 27 Oct 2026
   PostgreSQL version - works in pgAdmin / psql / DBeaver / onecompiler.com/postgresql
   ============================================================ */


/* ------------------------------------------------------------
   SETUP (skip this block if you already ran the original
   sialkot_venues_practice.sql - it creates the same tables)
   NULL = information not shown / not publicly listed
   ------------------------------------------------------------ */
DROP TABLE IF EXISTS VenuePractice;
DROP TABLE IF EXISTS Package;
DROP TABLE IF EXISTS Venue;

CREATE TABLE Venue (
    VenueId           INT PRIMARY KEY,
    VenueName         VARCHAR(100),
    Address           VARCHAR(150),
    Road              VARCHAR(60),
    Category          VARCHAR(30),
    Rating            DECIMAL(2,1),
    ReviewCount       INT,
    Accessibility     VARCHAR(50),
    HoursAtCapture    VARCHAR(40),
    PublishedPricePKR INT
);

INSERT INTO Venue VALUES
(1,  'G2 Marquee',                              'Tariq Rd',                                           'Tariq Rd',                 'Wedding venue',   4.5,  624, 'Wheelchair accessible entrance', NULL,                     NULL),
(2,  'Grace Marquee',                           '17 Khawaja Safdar Rd',                               'Khawaja Safdar Rd',        'Banquet hall',    4.4, 1402, 'Wheelchair accessible entrance', 'Open - Closes 11 PM',    150000),
(3,  'D-2 Marquee (Deewan-e-Khas)',             'D2 Marquee, Deewan-e-Khas',                          NULL,                       'Wedding service', 4.4,  300, 'Wheelchair accessible entrance', 'Open - Closes 10 PM',    NULL),
(4,  'Qasr-e-Iqbal Marquee',                    'Eimanabad Rd',                                       'Eimanabad Rd',             'Banquet hall',    4.3,  562, 'Wheelchair accessible entrance', 'Open - Closes 10:30 PM', NULL),
(5,  'Venus Marriage Hall Sialkot',             'Sublime Chowk, Wazirabad Rd',                        'Wazirabad Rd',             'Wedding venue',   4.0,  586, 'Wheelchair accessible entrance', 'Open - Closes 12 AM',    NULL),
(6,  'The Best Marriage Hall',                  'HH42+8X6, Gondal Saidpur Road, near Fresh Sweet',    'Gondal Saidpur Road',      'Banquet hall',    4.1,  448, 'Wheelchair accessible entrance', NULL,                     NULL),
(7,  'The Palm Marquee',                        'Diamond City, Chaprar Rd',                           'Chaprar Rd',               'Event venue',     4.2,  338, 'Wheelchair accessible entrance', 'Open - Closes 11 PM',    NULL),
(8,  'Rehmat Marriage Hall Hotel and Restaurant','FFQF+M5C, Rehmat Town Noul, Wazirabad Rd',          'Wazirabad Rd',             'Banquet hall',    4.0,  848, 'Wheelchair accessible entrance', 'Open - Closes 11 PM',    NULL),
(9,  'Cantt View Marquee',                      'Khawaja Safdar Road, near Fatima Jinnah Park',       'Khawaja Safdar Rd',        'Banquet hall',    4.3,  738, 'Wheelchair accessible entrance', 'Open - Closes 10 PM',    NULL),
(10, 'Mughal-e-Azam Marriage Hall',             'FGGC+9JV, Haji Pura Rd',                             'Haji Pura Rd',             'Wedding venue',   4.0,  652, 'Wheelchair accessible entrance', 'Open - Closes 10:30 PM', NULL),
(11, 'Tulip Marquee',                           'Eimanabad Rd',                                       'Eimanabad Rd',             'Event venue',     4.3,  625, 'Wheelchair accessible entrance', 'Open - Closes 10 PM',    NULL),
(12, 'Four Seasons Banquet Hall',               'Ugoki Rd',                                           'Ugoki Rd',                 'Banquet hall',    4.2,  599, 'Wheelchair accessible entrance', 'Open - Closes 11 PM',    NULL),
(13, 'Memories Marriage Hall',                  'FFQC+MPH',                                           NULL,                       'Wedding venue',   4.0,  240, 'Wheelchair accessible entrance', NULL,                     NULL),
(14, 'Grand Events Marquee',                    'FHXR+VMG, Chenab Rangers Rd, near Rangers Headquarters','Chenab Rangers Rd',     'Event venue',     4.4,  468, 'Wheelchair accessible entrance', NULL,                     NULL),
(15, 'Singhar Marriage Hall',                   'FGGP+6WV, Eimanabad Rd',                             'Eimanabad Rd',             'Wedding venue',   3.9,  498, 'Wheelchair accessible entrance', 'Open - Closes 10 PM',    NULL),
(16, 'i2 Luxury Events',                        'Chenab Rangers Rd, near Kent Housing',               'Chenab Rangers Rd',        'Wedding venue',   4.9,   13, NULL,                             'Open - Closes 10 PM',    NULL),
(17, 'Qasr-e-Saleem Marquee',                   '3 KM Sialkot - Pasrur Rd',                           'Sialkot - Pasrur Rd',      'Banquet hall',    4.8,   33, NULL,                             'Open - Closes 8 PM',     NULL),
(18, 'Unique Events Marquee',                   'Family Park, Aziz Bhatti Shaheed Road',              'Aziz Bhatti Shaheed Road', 'Wedding venue',   3.9,  120, NULL,                             'Open - Closes 10:30 PM', NULL),
(19, 'The Rose Palace',                         'FGHF+4GV, Haji Pura Rd, near Punjab College',        'Haji Pura Rd',             'Wedding venue',   4.0,  215, 'Wheelchair accessible entrance', 'Open 24 hours',          NULL),
(20, 'Sadiq Awan Marriage Hall',                'FH67+63R, Saddique Pura Awan Chowk Road',            'Saddique Pura Awan Chowk Road','Event venue',  4.1,  473, 'Wheelchair accessible entrance', 'Open - Closes 10 PM',    NULL);

CREATE TABLE Package (
    PackageId    INT PRIMARY KEY,
    VenueName    VARCHAR(100),
    PackageName  VARCHAR(50),
    PricePKR     INT,
    PriceBasis   VARCHAR(30)
);
INSERT INTO Package VALUES (1, 'Grace Marquee', 'Hall booking', 150000, 'per event');

-- Test the setup:
SELECT * FROM Venue LIMIT 3;
-- Result: 3 rows (G2 Marquee, Grace Marquee, D-2 Marquee). Setup worked.



/* ============================================================
   TASK 1 - Know your venues
   ============================================================ */

-- Q1: VenueName, Category and Rating of the first 5 venues
SELECT VenueName, Category, Rating
FROM Venue
LIMIT 5;
-- Result: 5 rows. First is G2 Marquee (Wedding venue, 4.5), second Grace Marquee (Banquet hall, 4.4).
-- Without ORDER BY, "first" just means the first rows stored in the table.

-- Q2: Each Category once (no repeats)
SELECT DISTINCT Category
FROM Venue;
-- Result: 4 rows - Wedding venue, Banquet hall, Wedding service, Event venue.
-- Sialkot venues fall into only 4 Google Maps categories.

-- Q3: How many different roads do the venues stand on?
SELECT COUNT(DISTINCT Road) AS DifferentRoads
FROM Venue;
-- Result: 12. COUNT(DISTINCT ...) ignores NULL, so the 2 venues with no Road are not counted.

-- Q4: Venues in the category 'Banquet hall'
SELECT *
FROM Venue
WHERE Category = 'Banquet hall';
-- Result: 7 venues; the first is Grace Marquee. Banquet halls are 7 of the 20 venues (35%).

-- Q5: Venues on 'Eimanabad Rd'
SELECT VenueName, Road
FROM Venue
WHERE Road = 'Eimanabad Rd';
-- Result: 3 venues - Qasr-e-Iqbal Marquee, Tulip Marquee, Singhar Marriage Hall.
-- Eimanabad Rd is a good road for a client who wants several venues to compare in one trip.

-- Q6: The 3 highest-rated venues
SELECT VenueName, Rating, ReviewCount
FROM Venue
ORDER BY Rating DESC
LIMIT 3;
-- Result: i2 Luxury Events 4.9, Qasr-e-Saleem Marquee 4.8, G2 Marquee 4.5.
-- Note: the top 2 have very few reviews (13 and 33).

-- Q7: The 5 venues with the most reviews
SELECT VenueName, ReviewCount, Rating
FROM Venue
ORDER BY ReviewCount DESC
LIMIT 5;
-- Result: Grace 1402, Rehmat 848, Cantt View 738, Mughal-e-Azam 652, Tulip 625.
-- These are the most "proven" venues - lots of customers have rated them.

-- Q8: All venues sorted by Rating (high to low); ties -> most reviews first
SELECT VenueName, Rating, ReviewCount
FROM Venue
ORDER BY Rating DESC, ReviewCount DESC;
-- Result: 20 rows. First: i2 Luxury Events (4.9). Last: Unique Events Marquee (3.9, 120),
-- just after Singhar (3.9, 498) - the tie at 3.9 is broken by ReviewCount.

-- THINK 1: i2 Luxury Events is #1 with 4.9 stars but only 13 reviews. Is it safe to recommend?
-- ANSWER: No, not on its own. 13 reviews is a very small sample - a few friendly reviews
-- can give 4.9, and one bad review would drop it a lot. A venue like Grace Marquee
-- (4.4 from 1,402 reviews) is much more reliable. To make the ranking fairer I would
-- add a minimum review count, e.g. WHERE ReviewCount >= 100 (or 200), and then sort by Rating:
--   SELECT VenueName, Rating, ReviewCount FROM Venue
--   WHERE ReviewCount >= 100 ORDER BY Rating DESC, ReviewCount DESC;
-- Another option is a review-weighted score (rating combined with number of reviews).
-- I would tell the client that i2 looks promising but is "new / not enough reviews to judge".



/* ============================================================
   TASK 2 - Filters and missing data
   ============================================================ */

-- Q9: Rating 4.3 or more AND more than 500 reviews
SELECT VenueName, Rating, ReviewCount
FROM Venue
WHERE Rating >= 4.3 AND ReviewCount > 500;
-- Result: 5 venues - G2 Marquee, Grace Marquee, Qasr-e-Iqbal, Cantt View, Tulip.
-- These are both well rated and well proven: the safest recommendations.

-- Q10: Venues that are 'Event venue' OR 'Wedding service'
SELECT VenueName, Category
FROM Venue
WHERE Category = 'Event venue' OR Category = 'Wedding service';
-- Result: 5 venues (4 Event venue + 1 Wedding service: D-2 Marquee).

-- Q11: Venues that are NOT in the category 'Wedding venue'
SELECT VenueName, Category
FROM Venue
WHERE NOT Category = 'Wedding venue';
-- Result: 12 venues (7 Banquet hall + 4 Event venue + 1 Wedding service). 20 - 8 = 12.

-- Q12: Venues with no Accessibility information
SELECT VenueName, Accessibility
FROM Venue
WHERE Accessibility IS NULL;
-- Result: 3 venues - i2 Luxury Events, Qasr-e-Saleem Marquee, Unique Events Marquee.
-- Use IS NULL, not "= NULL" (that never returns rows).

-- Q13: Venues with no opening-hours information
SELECT VenueName, HoursAtCapture
FROM Venue
WHERE HoursAtCapture IS NULL;
-- Result: 4 venues - G2 Marquee, The Best Marriage Hall, Memories Marriage Hall, Grand Events Marquee.

-- Q14: Venues with no Road
SELECT VenueName, Address, Road
FROM Venue
WHERE Road IS NULL;
-- Result: 2 venues - D-2 Marquee (Deewan-e-Khas) and Memories Marriage Hall.
-- Their Address is also not a normal road address (a name / plus code only).

-- Q15: How many venues have no published price?
SELECT COUNT(*) AS NoPriceVenues
FROM Venue
WHERE PublishedPricePKR IS NULL;
-- Result: 19. Only 1 of 20 venues (Grace Marquee) has a public price.

-- Q16: Rating 4.0 or higher AND Accessibility info present
SELECT VenueName, Rating, Accessibility
FROM Venue
WHERE Rating >= 4.0 AND Accessibility IS NOT NULL;
-- Result: 16 venues. 17 venues have accessibility info, minus Singhar Marriage Hall (3.9).

-- THINK 2: 19 of 20 venues have no published price. A client says "show me venues under PKR 200,000".
-- What goes wrong with WHERE PublishedPricePKR < 200000? What should I tell the client?
-- ANSWER: The query would return only 1 venue (Grace Marquee, 150,000). The other 19 venues are NOT
-- excluded because they are expensive - their price is NULL (unknown), and a comparison with NULL is
-- never true, so SQL silently drops them. The result looks like "only one venue is cheap" but really
-- it means "we only know the price of one venue". I would tell the client that prices are not public for
-- 19 of 20 venues, so we cannot filter by budget from this data; we need to call the venues for written
-- quotations (price, date, capacity, tax, inclusions) before comparing. Grace Marquee at PKR 150,000 is the
-- only one with a published price (and that price comes from a third-party listing, so also confirm it).



/* ============================================================
   TASK 3 - Market report
   ============================================================ */

-- Q17: Lowest and highest Rating
SELECT MIN(Rating) AS LowestRating, 
MAX(Rating) AS HighestRating
FROM Venue;
-- Result: 3.9 and 4.9.

-- Q18: Smallest and biggest ReviewCount
SELECT MIN(ReviewCount) AS SmallestReviewCount, 
MAX(ReviewCount) AS BiggestReviewCount
FROM Venue;
-- Result: 13 and 1,402. A huge gap, so a rating means very different things for different venues.

-- Q19: How many venues are in the table?
SELECT COUNT(*) AS TotalVenues
FROM Venue;
-- Result: 20.

-- Q20: How many venues have a published price?
SELECT COUNT(PublishedPricePKR) AS VenuesWithPrice
FROM Venue;
-- Result: 1. COUNT(column) skips NULLs; only Grace Marquee has a price.

-- Q21: Total number of reviews across all venues
SELECT SUM(ReviewCount) AS TotalReviews
FROM Venue;
-- Result: 9,782.

-- Q22: Average Rating of all venues
SELECT ROUND(AVG(Rating), 3) AS AvgRating
FROM Venue;
-- Result: 4.235 (about 4.2). A typical Sialkot venue is rated a little above 4.2.

-- Q23: Average number of reviews per venue
SELECT ROUND(AVG(ReviewCount), 1) AS AvgReviews
FROM Venue;
-- Result: 489.1 reviews per venue.

-- Q24: Average Rating of 'Banquet hall' venues only
SELECT ROUND(AVG(Rating), 1) AS AvgBanquetRating
FROM Venue
WHERE Category = 'Banquet hall';
-- Result: 4.3 (a bit above the overall average of 4.235).

-- Q25: How many venues have more than 500 reviews?
SELECT COUNT(*) AS VenuesOver500Reviews
FROM Venue
WHERE ReviewCount > 500;
-- Result: 9 venues (nearly half of the market has a solid review base).

-- Q26 (Challenge): Review-weighted average rating (big venues count more)
SELECT ROUND(SUM(Rating * ReviewCount) / SUM(ReviewCount), 2) AS WeightedAvgRating
FROM Venue;
-- Result: 4.21, slightly lower than the simple average 4.235.

-- THINK 3: Q19 gives 20 but Q20 gives 1 from the same table. Why? Why is the weighted average (Q26)
-- lower than the simple average (Q22)? Which one would I report to my manager?
-- ANSWER: COUNT(*) counts every row, while COUNT(PublishedPricePKR) counts only rows where that column is
-- NOT NULL. 19 venues have no price, so they are skipped and only 1 is counted.
-- The weighted average is lower because the venues with the fewest reviews have the highest ratings
-- (i2 4.9 with 13 reviews, Qasr-e-Saleem 4.8 with 33), and in the simple average they count as much as
-- Grace (4.4 with 1,402 reviews). In the weighted average, big venues with many reviews (many of them rated
-- 4.0 - 4.4, e.g. Rehmat 4.0 with 848 reviews and Mughal-e-Azam 4.0 with 652) count more, so the
-- number goes down. I would report the weighted average (about 4.21) as the main figure because it
-- reflects what most customers actually experienced, and mention the simple average (4.235) next to it.



/* ============================================================
   TASK 4 - Update the directory (on a practice copy only)
   ============================================================ */

-- a) Set up: make a practice copy. Never change the real table.
DROP TABLE IF EXISTS VenuePractice;
CREATE TABLE VenuePractice AS SELECT * FROM Venue;

SELECT COUNT(*) AS TotalVenues FROM VenuePractice;
-- Result: 20. The practice copy has the same rows as Venue.

-- b) INSERT a new venue (VenueId 21)
INSERT INTO VenuePractice (VenueId, VenueName, Road, Category, Rating, ReviewCount)
VALUES (21, 'Royal Garden Marquee', 'Tariq Rd', 'Wedding venue', 4.5, 100);

SELECT COUNT(*) AS TotalVenues FROM VenuePractice;
-- Result: 21 (was 20).
SELECT COUNT(*) AS WeddingVenues FROM VenuePractice WHERE Category = 'Wedding venue';
-- Result: 9 (was 8).
SELECT COUNT(*) AS NoAccessibilityInfo FROM VenuePractice WHERE Accessibility IS NULL;
-- Result: 4 (was 3) - the new venue has no Accessibility yet, so it is NULL.

-- c) UPDATE venue 21: Rating 4.7 and ReviewCount 150 (check first with SELECT, same WHERE)
SELECT VenueId, VenueName, Rating, ReviewCount
FROM VenuePractice
WHERE VenueId = 21;
-- Result (before): 1 row - Rating 4.5, ReviewCount 100. Only this row will change.

UPDATE VenuePractice
SET Rating = 4.7, ReviewCount = 150
WHERE VenueId = 21;

SELECT VenueId, VenueName, Rating, ReviewCount
FROM VenuePractice
WHERE VenueId = 21;
-- Result (after): Rating 4.7 and ReviewCount 150.

-- d) UPDATE venue 21: Accessibility = 'Wheelchair accessible entrance'
SELECT VenueId, VenueName, Accessibility
FROM VenuePractice
WHERE VenueId = 21;
-- Result (before): 1 row, Accessibility is NULL.

UPDATE VenuePractice
SET Accessibility = 'Wheelchair accessible entrance'
WHERE VenueId = 21;

SELECT COUNT(*) AS NoAccessibilityInfo
FROM VenuePractice
WHERE Accessibility IS NULL;
-- Result: 3 - back to the original 3 venues with no info.

-- e) DELETE venue 21 (check first with SELECT, same WHERE)
SELECT VenueId, VenueName
FROM VenuePractice
WHERE VenueId = 21;
-- Result (before): 1 row - exactly the one I want to delete.

DELETE FROM VenuePractice
WHERE VenueId = 21;

SELECT COUNT(*) AS TotalVenues FROM VenuePractice;
-- Result: 20 - back to the original.
SELECT COUNT(*) AS WeddingVenues FROM VenuePractice WHERE Category = 'Wedding venue';
-- Result: 8 - back to the original.

-- THINK 4: 17 of 20 venues are listed as wheelchair accessible and 3 are NULL.
-- Can I say those 3 are not accessible? How would I word this in a report to a client?
-- ANSWER: No. NULL means the information was not shown in the source (Google Maps), not that the
-- venue is inaccessible. The 3 venues may well be accessible - we just do not know. Saying "not
-- accessible" would be an unsupported claim and could mislead or unfairly hurt those venues.
-- Wording for the client: "17 of the 20 venues show a wheelchair-accessible entrance on Google Maps.
-- For 3 venues (i2 Luxury Events, Qasr-e-Saleem Marquee, Unique Events Marquee) accessibility
-- information is not listed, so we cannot confirm either way. Please check with the venue directly
-- if step-free access is important."

-- End of file. Rule followed: a SELECT with the same WHERE was run before every UPDATE and DELETE,
-- and all changes were made on VenuePractice, never on the real Venue table.
