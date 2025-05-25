-- Non-Correlated Subquery:
-- Find all properties where the average rating is greater than 4.0
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night
FROM properties p
WHERE p.property_id IN (
    SELECT 
        r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
)
ORDER BY p.property_id;

-- Correlated Subquery:
-- Find users who have made more than 3 bookings
SELECT 
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.id
) > 3
ORDER BY u.id;
