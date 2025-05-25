-- Measure performance BEFORE indexing

EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = 101;

EXPLAIN ANALYZE
SELECT * FROM bookings WHERE property_id = 202;

EXPLAIN ANALYZE
SELECT * FROM bookings WHERE start_date >= '2025-06-01';

EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'user@example.com';

EXPLAIN ANALYZE
SELECT b.*, p.name
FROM bookings b
JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date >= '2025-06-01';

-- Create indexes on frequently used columns

CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_start_date ON bookings(start_date);
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_users_email ON users(email);

-- Measure performance AFTER indexing

EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = 101;

EXPLAIN ANALYZE
SELECT * FROM bookings WHERE property_id = 202;

EXPLAIN ANALYZE
SELECT * FROM bookings WHERE start_date >= '2025-06-01';

EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'user@example.com';

EXPLAIN ANALYZE
SELECT b.*, p.name
FROM bookings b
JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date >= '2025-06-01';
