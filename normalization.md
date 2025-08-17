# Normalization to Third Normal Form (3NF)

This document explains how the Airbnb-like database schema was reviewed and adjusted to satisfy 3NF. It lists issues found, the normalization process (1NF → 2NF → 3NF), and the concrete schema changes applied.

## Objectives

- Eliminate redundancy and update anomalies
- Ensure each non-key attribute depends only on the key, the whole key, and nothing but the key
- Enforce data integrity with correct data types, keys, and constraints

## Target Entities

- users
- properties
- bookings
- payments
- reviews
- messages

## Issues Identified in the Initial Draft

1. Missing/invalid data types and syntax
   - Primary and foreign keys without explicit types
   - Invalid trailing commas and missing commas
   - Invalid ON UPDATE clause placement and MySQL specifics

2. Redundant/derived attributes
   - properties.location duplicated information derivable from address (or could be decomposed into a separate location dimension). Keeping both risks inconsistency (transitive dependency via property → address → location).
   - bookings.total_price is derivable from price_per_night and booking duration; storing it causes update anomalies (e.g., price change or date change requires manual recalculation).

3. Missing constraints
   - Not all relations had foreign key constraints
   - Missing checks (e.g., end_date > start_date, rating 1–5)

4. Indexing for performance
   - Missing indexes on foreign keys and commonly filtered columns

## Normalization Steps

### 1. First Normal Form (1NF)
Requirements: atomic columns, consistent data types, primary keys, no repeating groups.

Actions:
- Added explicit data types and primary keys to all tables with auto-increment surrogate keys (BIGINT UNSIGNED).
- Ensured each column stores a single atomic value (e.g., address is a single string; phone_number is a single field). If multiple phone numbers are required in future, they should be moved to a separate user_phones table.
- Removed invalid syntax and ensured consistent timestamps with created_at and updated_at where applicable.

Result: All tables have atomic attributes and clear primary keys.

### 2. Second Normal Form (2NF)
Requirements: all non-key attributes must depend on the whole primary key (no partial dependency on part of a composite key).

Actions:
- Used surrogate single-column primary keys across tables; thus 2NF reduces to ensuring each non-key attribute depends on that single key.
- Verified that, for each table, attributes are fully dependent on its primary key (e.g., properties.name depends on properties.property_id; bookings.start_date depends on bookings.booking_id; etc.).

Result: No partial dependencies exist.

### 3. Third Normal Form (3NF)
Requirements: remove transitive dependencies (non-key → non-key → key) and derived data.

Actions:
- Removed properties.location because it is derivable from address, and in practice location attributes (city/country) are functionally dependent on an address. Keeping both leads to potential inconsistencies (transitive dependency). If location dimensions are needed, introduce a separate locations table and reference it by location_id.
- Removed bookings.total_price as it is a derived attribute from price_per_night and the number of nights. This avoids redundancy and update anomalies. Compute this in queries or materialized views when needed.
- Kept enumerations (status, payment_method) as domain constraints; they do not violate 3NF because they depend solely on the row’s key. If the domain needs to be extensible or localized, migrate to lookup tables.

Result: All non-key attributes depend only on the key and are not transitively dependent on other non-key attributes.

## Constraints and Integrity

- Foreign keys with ON UPDATE CASCADE and ON DELETE CASCADE where appropriate:
  - properties.host_id → users.id
  - bookings.property_id → properties.property_id
  - bookings.user_id → users.id
  - payments.booking_id → bookings.booking_id
  - reviews.property_id → properties.property_id
  - reviews.user_id → users.id
  - messages.sender_id → users.id
  - messages.recipient_id → users.id
- Check constraints:
  - bookings: end_date > start_date
  - reviews: rating BETWEEN 1 AND 5
- Unique constraints:
  - users.email is unique

## Indexing

Added indexes on foreign keys and frequently filtered columns:
- properties(host_id)
- bookings(property_id), bookings(user_id), bookings(status)
- payments(booking_id)
- reviews(property_id), reviews(user_id)
- messages(sender_id), messages(recipient_id)

These support efficient joins and filtering without affecting normalization.

## Final Schema Changes (Summary)

- users
  - Added: explicit BIGINT UNSIGNED id with AUTO_INCREMENT; created_at/updated_at; unique(email)

- properties
  - Removed: location (redundant)
  - Added: host_id BIGINT UNSIGNED with FK to users(id); timestamps; index on host_id

- bookings
  - Removed: total_price (derived)
  - Added: timestamps; constraint end_date > start_date; FKs to users and properties; indexes

- payments
  - Added: FK to bookings; index on booking_id

- reviews
  - Added: FKs to users and properties; rating check; indexes

- messages
  - Added: FKs to users for sender/recipient; indexes

## Computing Derived Values in Queries

Example of calculating total booking price on the fly (MySQL):

```sql
SELECT
  b.booking_id,
  p.price_per_night,
  GREATEST(DATEDIFF(b.end_date, b.start_date), 0) AS nights,
  GREATEST(DATEDIFF(b.end_date, b.start_date), 0) * p.price_per_night AS total_price
FROM bookings b
JOIN properties p ON p.property_id = b.property_id;
```

Note: Adjust for inclusivity/exclusivity of end_date as per business rules. If additional fees/discounts are required, introduce a booking_charges table and compute totals via aggregation.

## Optional Future Normalizations

- Locations: If you need structured geo data (city/region/country, coordinates), create a locations table and reference it from properties via location_id, or decompose address into multiple atomic columns.
- Status/Payment Methods: If the set of values must be managed by admins or localized, convert ENUMs into lookup tables with FKs.
- Contact Methods: If users can have multiple phone numbers, move phone_number into a separate user_phones table.

## Outcome

The schema now adheres to 3NF: attributes are atomic, fully dependent on the primary key, and free of transitive dependencies or stored derived values. Referential integrity and domain constraints are enforced with appropriate keys, checks, and indexes.