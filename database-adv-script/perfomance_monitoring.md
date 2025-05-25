# Database Performance Monitoring and Refinement

## Objective
Continuously monitor and refine database performance by analyzing query execution plans and making schema or indexing adjustments.

---

## 1. Tools Used

- `EXPLAIN ANALYZE` – for measuring query execution time and identifying performance bottlenecks.
- PostgreSQL system views for indexing and statistics.

---

## 2. Sample Queries Monitored

### Query 1: Fetch user bookings
```sql
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE user_id = 1001;
