# Index Performance Analysis – Airbnb Clone Database

This document outlines the performance impact of adding indexes to frequently used columns in the database.

## Why Indexes?

Indexes help speed up data retrieval by allowing the database to locate records faster, especially in large datasets. We targeted high-usage columns found in:
- WHERE clauses
- JOIN conditions
- ORDER BY statements

---

## Indexes Created

| Table      | Column           | Index Name               | Use Case                                     |
|------------|------------------|--------------------------|----------------------------------------------|
| users      | email            | idx_users_email          | Login, email lookups                         |
| bookings   | user_id          | idx_bookings_user_id     | JOINs with users                             |
| bookings   | property_id      | idx_bookings_property_id | JOINs with properties                        |
| properties | location         | idx_properties_location  | Searching properties by location             |
| reviews    | property_id      | idx_reviews_property_id  | JOINs with properties to fetch reviews       |

---

## Performance Comparison (MySQL)

### Query Example (Before Indexing)

```sql
EXPLAIN SELECT * FROM bookings WHERE user_id = 'user-123';
