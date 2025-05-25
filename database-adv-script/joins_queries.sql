--INNER JOIN  Retrieve all bookings and the respective users who made those bookings
SELECT 
    bookings.booking_id,
    users.id AS user_id,
    users.first_name,
    users.last_name,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price
FROM bookings
INNER JOIN users ON bookings.user_id = users.id;

-- LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
SELECT 
    properties.property_id,
    properties.name AS property_name,
    reviews.review_id,
    reviews.rating,
    reviews.comment
FROM properties
LEFT JOIN reviews ON properties.property_id = reviews.property_id;

-- FULL OUTER JOIN: Retrieve all users and all bookings,
-- even if the user has no booking or a booking is not linked to a user
-- (PostgreSQL syntax; MySQL does not support FULL OUTER JOIN natively)
SELECT 
    users.id AS user_id,
    users.first_name,
    users.last_name,
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date
FROM users
FULL OUTER JOIN bookings ON users.id = bookings.user_id;
