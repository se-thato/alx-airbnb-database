# Airbnb Database System Requirements

## Objective
Design and implement a relational database schema for an Airbnb-like platform that allows users to list properties, make bookings, process payments, leave reviews, and send messages. The system must enforce data integrity, relationships, constraints, and indexing for performance optimization.


## Entities and Attributes

### 1. User
- `user_id`: UUID, Primary Key, Indexed
- `first_name`: VARCHAR, Not Null
- `last_name`: VARCHAR, Not Null
- `email`: VARCHAR, Unique, Not Null
- `password_hash`: VARCHAR, Not Null
- `phone_number`: VARCHAR, Nullable
- `role`: ENUM (guest, host, admin), Not Null
- `created_at`: TIMESTAMP, Default = CURRENT_TIMESTAMP

### 2. Property
- `property_id`: UUID, Primary Key, Indexed
- `host_id`: UUID, Foreign Key → User(user_id)
- `name`: VARCHAR, Not Null
- `description`: TEXT, Not Null
- `location`: VARCHAR, Not Null
- `pricepernight`: DECIMAL, Not Null
- `created_at`: TIMESTAMP, Default = CURRENT_TIMESTAMP
- `updated_at`: TIMESTAMP, Updated on row update

### 3. Booking
- `booking_id`: UUID, Primary Key, Indexed
- `property_id`: UUID, Foreign Key → Property(property_id)
- `user_id`: UUID, Foreign Key → User(user_id)
- `start_date`: DATE, Not Null
- `end_date`: DATE, Not Null
- `total_price`: DECIMAL, Not Null
- `status`: ENUM (pending, confirmed, canceled), Not Null
- `created_at`: TIMESTAMP, Default = CURRENT_TIMESTAMP

### 4. Payment
- `payment_id`: UUID, Primary Key, Indexed
- `booking_id`: UUID, Foreign Key → Booking(booking_id)
- `amount`: DECIMAL, Not Null
- `payment_date`: TIMESTAMP, Default = CURRENT_TIMESTAMP
- `payment_method`: ENUM (credit_card, paypal, stripe), Not Null

### 5. Review
- `review_id`: UUID, Primary Key, Indexed
- `property_id`: UUID, Foreign Key → Property(property_id)
- `user_id`: UUID, Foreign Key → User(user_id)
- `rating`: INTEGER (1–5), Not Null
- `comment`: TEXT, Not Null
- `created_at`: TIMESTAMP, Default = CURRENT_TIMESTAMP

### 6. Message
- `message_id`: UUID, Primary Key, Indexed
- `sender_id`: UUID, Foreign Key → User(user_id)
- `recipient_id`: UUID, Foreign Key → User(user_id)
- `message_body`: TEXT, Not Null
- `sent_at`: TIMESTAMP, Default = CURRENT_TIMESTAMP


## Relationships

- A **User** can be a **host** of many Properties.
- A **User** can make many **Bookings**.
- A **Property** can have many **Bookings**.
- A **Booking** is linked to one **Payment**.
- A **User** can write many **Reviews** for different Properties.
- A **Property** can have many **Reviews**.
- A **User** can send and receive many **Messages** from other users (self-referencing relationship).



## Constraints

### General
- Primary keys are required for all entities.
- All foreign key references must maintain referential integrity.

### Specific
- `email` in User must be unique.
- `rating` in Review must be between 1 and 5 (inclusive).
- `status` in Booking must be one of `pending`, `confirmed`, or `canceled`.
- `payment_method` must be one of `credit_card`, `paypal`, or `stripe`.



## Indexing

- All Primary Keys are indexed by default.
- Additional indexes:
  - `email` in User
  - `property_id` in Property and Booking
  - `booking_id` in Booking and Payment



## Future Considerations

- Add support for availability calendars for properties.
- Implement audit logging for actions.
- Add image storage for properties.
- Integrate location-based search functionality.

