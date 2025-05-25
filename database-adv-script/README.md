# SQL Join Queries – Airbnb Clone Advanced

This file contains advanced SQL join queries for the Airbnb clone database project.

## Queries Overview

1. **INNER JOIN** – Retrieves all bookings along with the users who made those bookings.
2. **LEFT JOIN** – Retrieves all properties and any associated reviews. Properties with no reviews are still included.
3. **FULL OUTER JOIN** – Retrieves all users and all bookings, including:
   - Users with no bookings.
   - Bookings not linked to any existing user (for integrity checking or orphan detection).

## Notes

- Ensure you're using a database engine that supports `FULL OUTER JOIN` (e.g., PostgreSQL).
- In MySQL, `FULL OUTER JOIN` can be simulated using `UNION` of a `LEFT JOIN` and a `RIGHT JOIN`.

```sql
-- MySQL alternative for FULL OUTER JOIN
SELECT 
    users.id AS user_id,
    users.first_name,
    users.last_name,
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date
FROM users
LEFT JOIN bookings ON users.id = bookings.user_id

UNION

SELECT 
    users.id AS user_id,
    users.first_name,
    users.last_name,
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date
FROM users
RIGHT JOIN bookings ON users.id = bookings.user_id;




-- Subqueries
# SQL Subqueries – Airbnb Clone Advanced

This script contains SQL subqueries written to explore both non-correlated and correlated use cases on the Airbnb clone database.

## Queries Overview

### 1. Non-Correlated Subquery
- **Purpose:** Retrieve all properties where the **average rating** is greater than **4.0**.
- **Logic:** A subquery calculates the average rating grouped by `property_id`. The outer query fetches properties matching those IDs.
- **Keyword used:** `HAVING`, `IN`

### 2. Correlated Subquery
- **Purpose:** Find all users who have made **more than 3 bookings**.
- **Logic:** A subquery inside the `WHERE` clause references the outer query's user ID, making it correlated.
- **Keyword used:** `SELECT COUNT(*)`, correlated `WHERE` condition'



--Aggregation
# SQL Aggregation and Window Functions – Airbnb Clone Advanced

This script contains SQL queries demonstrating the use of aggregation (`GROUP BY`, `COUNT`) and window functions (`RANK`) to analyze data in the Airbnb clone database.

## Queries Overview

### 1. Total Bookings per User
- **Purpose:** Count the total number of bookings each user has made.
- **Approach:** 
  - Use `COUNT()` on `booking_id`
  - Group by `user.id`
  - Uses `LEFT JOIN` to include users who haven't made bookings

### 2. Rank Properties by Total Bookings
- **Purpose:** Rank properties based on the total number of bookings.
- **Approach:** 
  - Use `COUNT()` on bookings
  - Apply `RANK()` window function
  - Group by `property_id`
  - Includes properties with 0 bookings via `LEFT JOIN`

## File Structure

