-- Index on users.id (often joined with bookings)
CREATE INDEX idx_users_id ON users(id);

-- Index on bookings.user_id (frequent JOIN)
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Index on bookings.property_id (frequent JOIN)
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Index on properties.property_id
CREATE INDEX idx_properties_id ON properties(property_id);

-- Index on payments.booking_id (frequent JOIN)
CREATE INDEX idx_payments_booking_id ON payments(booking_id);

-- Index on bookings.start_date for filtering or partitioning
CREATE INDEX idx_bookings_start_date ON bookings(start_date);
