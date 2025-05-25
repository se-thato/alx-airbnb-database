-- Initial query (non-optimized)
-- Retrieves all bookings with user, property, and payment details
SELECT
    b.booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location,
    pay.amount,
    pay.payment_method,
    b.start_date,
    b.end_date,
    b.total_price
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id;
