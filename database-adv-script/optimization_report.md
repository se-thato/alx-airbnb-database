# Query Optimization Report

## Objective
Refactor a complex query that retrieves all booking, user, property, and payment details to improve its execution performance.

---

## 1. Initial Query Analysis

### Query Overview
The original query joins four tables:
- `bookings`
- `users`
- `properties`
- `payments`

### Performance Test

Using:
```sql
EXPLAIN SELECT ...
