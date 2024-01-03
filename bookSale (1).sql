CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE ShippingAddresses (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE PaymentDetails (
    payment_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    card_number VARCHAR(16) NOT NULL,
    cardholder_name VARCHAR(100) NOT NULL,
    expiration_date VARCHAR(7) NOT NULL,
    cvv VARCHAR(4) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    review_text TEXT NOT NULL,
    rating DECIMAL(3, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_id INT NOT NULL,
    payment_amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Users (name, email, password) VALUES ('John Doe', 'johndoe@example.com', 'mypassword1');
INSERT INTO Users (name, email, password) VALUES ('Jane Smith', 'janesmith@example.com', 'mypassword2');
INSERT INTO Users (name, email, password) VALUES ('Alice Johnson', 'alicejohnson@example.com', 'mypassword3');
INSERT INTO Users (name, email, password) VALUES ('Bob Thompson', 'bobthompson@example.com', 'mypassword4');
INSERT INTO Users (name, email, password) VALUES ('Eve Brown', 'evebrown@example.com', 'mypassword5');

INSERT INTO ShippingAddresses (user_id, street_address, city, state, postal_code, country) VALUES (1, '1234 Elm Street', 'New York City', 'NY', '12345', 'USA');
INSERT INTO ShippingAddresses (user_id, street_address, city, state, postal_code, country) VALUES (2, '5678 Oak Avenue', 'Los Angeles', 'CA', '67890', 'USA');
INSERT INTO ShippingAddresses (user_id, street_address, city, state, postal_code, country) VALUES (3, '9101 Maple Lane', 'Chicago', 'IL', '45678', 'USA');
INSERT INTO ShippingAddresses (user_id, street_address, city, state, postal_code, country) VALUES (4, '2468 Birch Road', 'San Francisco', 'CA', '98765', 'USA');
INSERT INTO ShippingAddresses (user_id, street_address, city, state, postal_code, country) VALUES (5, '1357 Pine Drive', 'Miami', 'FL', '54321', 'USA');

INSERT INTO PaymentDetails (user_id, card_number, cardholder_name, expiration_date, cvv) VALUES (1, '1234567890123456', 'John Doe', '05/24', '123');
INSERT INTO PaymentDetails (user_id, card_number, cardholder_name, expiration_date, cvv) VALUES (2, '2345678901234567', 'Jane Smith', '06/23', '234');
INSERT INTO PaymentDetails (user_id, card_number, cardholder_name, expiration_date, cvv) VALUES (3, '3456789012345678', 'Alice Johnson', '07/22', '345');
INSERT INTO PaymentDetails (user_id, card_number, cardholder_name, expiration_date, cvv) VALUES (4, '4567890123456789', 'Bob Thompson', '08/21', '456');
INSERT INTO PaymentDetails (user_id, card_number, cardholder_name, expiration_date, cvv) VALUES (5, '5678901234567890', 'Eve Brown', '09/20', '567');

INSERT INTO Books (title, author, genre, price, quantity) VALUES ('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 9.99, 10);
INSERT INTO Books (title, author, genre, price, quantity) VALUES ('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 8.99, 5);
INSERT INTO Books (title, author, genre, price, quantity) VALUES ('1984', 'George Orwell', 'Science Fiction', 7.99, 15);
INSERT INTO Books (title, author, genre, price, quantity) VALUES ('Pride and Prejudice', 'Jane Austen', 'Romance', 6.99, 8);
INSERT INTO Books (title, author, genre, price, quantity) VALUES ('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 5.99, 20);

INSERT INTO Orders (user_id, book_id, quantity, order_date, status) VALUES (1, 1, 4, '2023-04-25', 'Completed');
INSERT INTO Orders (user_id, book_id, quantity, order_date, status) VALUES (2, 3, 7, '2023-04-25', 'Processing');
INSERT INTO Orders (user_id, book_id, quantity, order_date, status) VALUES (3, 2, 2, '2023-04-24', 'Cancelled');
INSERT INTO Orders (user_id, book_id, quantity, order_date, status) VALUES (4, 4, 8, '2023-04-24', 'Completed');
INSERT INTO Orders (user_id, book_id, quantity, order_date, status) VALUES (5, 5, 4, '2023-04-23', 'Completed');

INSERT INTO Reviews (user_id, book_id, review_text, rating) VALUES (1, 1, 'Great book! Highly recommended.', 4.5);
INSERT INTO Reviews (user_id, book_id, review_text, rating) VALUES (2, 3, 'Interesting dystopian novel.', 3.8);
INSERT INTO Reviews (user_id, book_id, review_text, rating) VALUES (3, 2, 'A classic with important themes.', 4.0);
INSERT INTO Reviews (user_id, book_id, review_text, rating) VALUES (4, 4, 'Delightful romance novel.', 4.2);
INSERT INTO Reviews (user_id, book_id, review_text, rating) VALUES (5, 5, 'Epic fantasy adventure.', 4.8);

INSERT INTO Cart (user_id, book_id, quantity) VALUES (1, 1, 2);
INSERT INTO Cart (user_id, book_id, quantity) VALUES (2, 3, 1);
INSERT INTO Cart (user_id, book_id, quantity) VALUES (3, 2, 3);
INSERT INTO Cart (user_id, book_id, quantity) VALUES (4, 4, 1);
INSERT INTO Cart (user_id, book_id, quantity) VALUES (5, 5, 2);


INSERT INTO Payments (user_id, order_id, payment_amount, payment_date) VALUES (1, 1, 19.98, '2023-04-25');
INSERT INTO Payments (user_id, order_id, payment_amount, payment_date) VALUES (2, 2, 7.99, '2023-04-25');
INSERT INTO Payments (user_id, order_id, payment_amount, payment_date) VALUES (3, 3, 23.97, '2023-04-24');
INSERT INTO Payments (user_id, order_id, payment_amount, payment_date) VALUES (4, 4, 6.99, '2023-04-24');
INSERT INTO Payments (user_id, order_id, payment_amount, payment_date) VALUES (5, 5, 11.98, '2023-04-23');

