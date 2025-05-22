CREATE TABLE  users (
    id  PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);


CREATE TABLE properties (
    property_id SERIAL PRIMARY KEY,
    host_id FOREIGN KEY REFERENCES users(id),
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    address VARCHAR(255) NOT NULL,
    location VARCHAR(100) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);


CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    property_id FOREIGN KEY REFERENCES properties(property_id),
    user_id FOREIGN KEY REFERENCES users(id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending' NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);



CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    booking_id FOREIGN KEY REFERENCES bookings(booking_id),
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'bank_transfer') NOT NULL,
);


CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    property_id FOREIGN KEY REFERENCES properties(property_id),
    user_id FOREIGN KEY REFERENCES users(id),
    rating INT CHECK (rating >= 1 AND rating <= 5) NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);


CREATE TABLE messages (
    message_id SERIAL PRIMARY KEY,
    sender_id FOREIGN KEY REFERENCES users(id),
    recipient_id FOREIGN KEY REFERENCES users(id),
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

