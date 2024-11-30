-- sample users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
(uuid_generate_v4(), 'Alice', 'Johnson', 'alice@example.com', 'hashed_password_1', '1234567890', 'guest', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'Bob', 'Smith', 'bob@example.com', 'hashed_password_2', '0987654321', 'host', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'Eve', 'Williams', 'eve@example.com', 'hashed_password_3', NULL, 'admin', CURRENT_TIMESTAMP);

-- sample properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
(uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'bob@example.com'), 'Cozy Cottage', 'A small, cozy cottage in the woods.', 'Woodland, CA', 150.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'bob@example.com'), 'Urban Apartment', 'A modern apartment in the heart of the city.', 'San Francisco, CA', 200.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

--sample bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
(uuid_generate_v4(), 
 (SELECT property_id FROM Property WHERE name = 'Cozy Cottage'), 
 (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
 '2024-12-01', '2024-12-05', 600.00, 'confirmed', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 
 (SELECT property_id FROM Property WHERE name = 'Urban Apartment'), 
 (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
 '2024-12-10', '2024-12-12', 400.00, 'pending', CURRENT_TIMESTAMP);

-- sample payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
(uuid_generate_v4(), 
 (SELECT booking_id FROM Booking WHERE status = 'confirmed'), 
 600.00, CURRENT_TIMESTAMP, 'credit_card'),
(uuid_generate_v4(), 
 (SELECT booking_id FROM Booking WHERE status = 'pending'), 
 400.00, CURRENT_TIMESTAMP, 'paypal');

-- sample reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
(uuid_generate_v4(), 
 (SELECT property_id FROM Property WHERE name = 'Cozy Cottage'), 
 (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
 5, 'Amazing place! Highly recommend.', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 
 (SELECT property_id FROM Property WHERE name = 'Urban Apartment'), 
 (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
 4, 'Very modern and clean, but a bit noisy.', CURRENT_TIMESTAMP);

-- sample message
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
(uuid_generate_v4(), 
 (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
 (SELECT user_id FROM User WHERE email = 'bob@example.com'), 
 'Hi Bob, I have some questions about the cottage.', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 
 (SELECT user_id FROM User WHERE email = 'bob@example.com'), 
 (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
 'Sure, feel free to ask!', CURRENT_TIMESTAMP);
