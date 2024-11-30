-- Query 1: Find all bookings within a date range
EXPLAIN ANALYZE 
SELECT * FROM Booking
WHERE start_date BETWEEN '2022-01-01' AND '2022-06-30';

-- Query 2: Find all properties with reviews and their average ratings
EXPLAIN ANALYZE
SELECT p.property_id, p.name, AVG(r.rating) as avg_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id;

-- Query 3: Find all bookings with user details and payment info
EXPLAIN ANALYZE
SELECT b.booking_id, u.first_name, u.last_name, p.name, b.start_date, b.end_date, pay.amount
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN Payment pay ON b.booking_id = pay.booking_id;

-- Index on start_date in the Booking table to optimize query
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- Index on property_id in the Review table to optimize join with Property
CREATE INDEX idx_review_property_id ON Review(property_id);

-- Index on user_id for the User table to optimize join with Booking
CREATE INDEX idx_user_user_id ON User(user_id);

-- Query after adding indexes to compare performance improvements
EXPLAIN ANALYZE 
SELECT * FROM Booking
WHERE start_date BETWEEN '2022-01-01' AND '2022-06-30';

EXPLAIN ANALYZE
SELECT p.property_id, p.name, AVG(r.rating) as avg_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id;

EXPLAIN ANALYZE
SELECT b.booking_id, u.first_name, u.last_name, p.name, b.start_date, b.end_date, pay.amount
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN Payment pay ON b.booking_id = pay.booking_id;
