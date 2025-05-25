# Partitioning Performance Report

## Objective
Optimize query performance on a large `bookings` table by partitioning it based on the `start_date`.

---

## 1. Implementation Summary

- Partitioned the `bookings` table by RANGE on the `start_date` column.
- Created separate partitions for years: 2022, 2023, and 2024.

---

## 2. Testing Method

We used the following query to test performance:

```sql
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2023-06-01' AND '2023-06-30';
