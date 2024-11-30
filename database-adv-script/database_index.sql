-- 1. Index on user_id in the Booking table (frequently used in JOINs with User table)
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- 2. Index on property_id in the Booking table (frequently used in JOINs with Property table)
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- 3. Index on user_id in the Property table (host_id is a foreign key referring to User)
CREATE INDEX idx_property_user_id ON Property(host_id);

-- 4. Index on email in the User table (frequently used for lookups and login operations)
CREATE INDEX idx_user_email ON User(email);

-- 5. Index on created_at in the Booking table (often used for ordering or filtering by date)
CREATE INDEX idx_booking_created_at ON Booking(created_at);

-- 6. Index on created_at in the Property table (frequently used for ordering properties by creation date)
CREATE INDEX idx_property_created_at ON Property(created_at);

-- 7. Index on status in the Booking table (for filtering bookings by status)
CREATE INDEX idx_booking_status ON Booking(status);
