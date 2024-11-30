-- Query 1: Find all properties where the average rating is greater than 4.0 (Non-Correlated Subquery)
SELECT 
    property_id, 
    name AS property_name, 
    location, 
    pricepernight
FROM Property
WHERE property_id IN (
    SELECT 
        property_id
    FROM Review
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

-- Query 2: Find users who have made more than 3 bookings (Correlated Subquery)
SELECT 
    user_id, 
    first_name, 
    last_name, 
    email
FROM User
WHERE (
    SELECT COUNT(*) 
    FROM Booking 
    WHERE Booking.user_id = User.user_id
) > 3;
