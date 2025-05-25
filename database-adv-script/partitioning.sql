-- Step 1: Rename the original bookings table
ALTER TABLE bookings RENAME TO bookings_backup;

-- Step 2: Recreate the bookings table with partitioning by RANGE on start_date
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    user_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(10) DEFAULT 'pending' NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Step 3: Create monthly or yearly partitions
-- Example: yearly partitions

CREATE TABLE bookings_2022 PARTITION OF bookings
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE bookings_2023 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Add more as needed...

-- Step 4: Optional – Copy existing data back if needed
-- INSERT INTO bookings SELECT * FROM bookings_backup;

-- Step 5: Test performance with EXPLAIN
-- EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2023-06-01' AND '2023-06-30';
