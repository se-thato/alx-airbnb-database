INSERT INTO users(username, email, password_hash, phone_number)
VALUES  (1, 'Thato', 'Selepe', 'thatoselepe@gmail.com', 'pass122', '0612345677'),
        (2, 'Thabanga', 'Mokhantso', 'thabang11@gmail.com', 'pass123', '0712345678'),
        (3, 'Wiseman', 'Zondo', 'wiseman@gmail.com', 'pass124', '0812345679'),
        

INSERT INTO properties(host_id, name, description, address, location, price_per_night)
VALUES  (1, 'Thato House', 'A beautiful house in the city center', '123 Main St, City Center', 'City Center', 100.00),
        (2, 'Thabanga Apartment', 'A cozy apartment near the beach', '456 Beach Rd, Beachfront', 'Beachfront', 150.00),
        (3, 'Wiseman Villa', 'A luxurious villa with a pool', '789 Villa St, Suburbia', 'Suburbia', 200.00);
        

INSERT INTO bookings(property_id, user_id, start_date, end_date, total_price, status)
VALUES  (1, 1, '2023-10-01', '2023-10-05', 500.00, 'confirmed'),
        (2, 2, '2023-10-10', '2023-10-15', 750.00, 'pending'),
        (3, 3, '2023-10-20', '2023-10-25', 1000.00, 'cancelled');


INSERT INTO payments(booking_id, amount, payment_date, payment_method)
VALUES  (1, 500.00, '2023-10-01', 'credit_card'),
        (2, 750.00, '2023-10-10', 'paypal'),
        (3, 1000.00, '2023-10-20', 'bank_transfer');


INSERT INTO reviews(property_id, user_id, rating, comment)
VALUES  (1, 1, 5, 'Amazing place! Highly recommend.'),
        (2, 2, 4, 'Very nice apartment, but a bit noisy.'),
        (3, 3, 3, 'Okay stay, but could be better.');


INSERT INTO messages(sender_id, recipient_id, message_body)
VALUES  (1, 2, 'Hello! I am interested in your property.'),
        (2, 3, 'Hi! Can you provide more details about the booking?'),
        (3, 1, 'Thank you for your review! We appreciate your feedback.');