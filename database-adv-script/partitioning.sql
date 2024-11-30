-- Step 1: Create the partitioned Booking table based on the start_date column
CREATE TABLE Booking_partitioned (
    booking_id UUID PRIMARY KEY,
    user_id UUID,
    property_id UUID,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES User(user_id),
    CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES Property(property_id)
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions for each year (adjust as needed for your dataset)
CREATE TABLE Booking_2021 PARTITION OF Booking_partitioned
    FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE Booking_2022 PARTITION OF Booking_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE Booking_2023 PARTITION OF Booking_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- Step 3: Test query performance before partitioning
EXPLAIN ANALYZE 
SELECT * FROM Booking 
WHERE start_date BETWEEN '2022-06-01' AND '2022-06-30';

-- after partitioning
EXPLAIN ANALYZE 
SELECT * FROM Booking_partitioned 
WHERE start_date BETWEEN '2022-06-01' AND '2022-06-30';

-- Step 4: Adding index on the start_date column for partitioned tables (optional but recommended)
CREATE INDEX idx_booking_start_date_2021 ON Booking_2021(start_date);
CREATE INDEX idx_booking_start_date_2022 ON Booking_2022(start_date);
CREATE INDEX idx_booking_start_date_2023 ON Booking_2023(start_date);
