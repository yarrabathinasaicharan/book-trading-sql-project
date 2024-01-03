-- Retrieve all orders along with user details, book details, and payment details:
SELECT o.order_id, u.name AS user_name, u.email AS user_email, b.title AS book_title, p.payment_amount
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
JOIN Books b ON o.book_id = b.book_id
JOIN Payments p ON o.order_id = p.order_id;

-- Retrieve all reviews along with user details and book details:
SELECT r.review_id, u.name AS user_name, b.title AS book_title, r.review_text, r.rating
FROM Reviews r
JOIN Users u ON r.user_id = u.user_id
JOIN Books b ON r.book_id = b.book_id;


-- Retrieve all books along with their average rating:
SELECT b.book_id, b.title, b.author, b.genre, b.price, b.quantity, AVG(r.rating) AS average_rating
FROM Books b
LEFT JOIN Reviews r ON b.book_id = r.book_id
GROUP BY b.book_id;

-- Retrieve all orders for a specific user along with book details:
SELECT o.order_id, b.title AS book_title, o.order_date, o.status
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
WHERE o.user_id = 1;

-- Retrieve all books that have not been reviewed yet:
SELECT b.book_id, b.title, b.author, b.genre, b.price, b.quantity
FROM Books b
LEFT JOIN Reviews r ON b.book_id = r.book_id
WHERE r.review_id IS NULL;

-- Retrieve all orders that have been paid:
SELECT o.order_id, o.user_id, b.title AS book_title, p.payment_amount, p.payment_date
FROM Orders o
JOIN Payments p ON o.order_id = p.order_id
JOIN Books b ON o.book_id = b.book_id;

-- Retrieve all users along with their shipping addresses:
SELECT u.user_id, u.name, u.email, sa.street_address, sa.city, sa.state, sa.postal_code, sa.country
FROM Users u
JOIN ShippingAddresses sa ON u.user_id = sa.user_id;

-- Retrieve all books along with their total quantity sold:
SELECT b.book_id, b.title, b.author, b.genre, b.price, b.quantity, SUM(o.quantity) AS total_quantity_sold
FROM Books b
JOIN Orders o ON b.book_id = o.book_id
GROUP BY b.book_id;

-- Retrieve all orders along with user details and total order amount:
SELECT o.order_id, u.name AS user_name, u.email AS user_email, SUM(b.price * o.quantity) AS total_order_amount
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
JOIN Books b ON o.book_id = b.book_id
GROUP BY o.order_id;

-- Retrieve all books along with their average rating and total number of reviews:
SELECT b.book_id, b.title, b.author, b.genre, b.price, b.quantity, AVG(r.rating) AS average_rating, COUNT(r.review_id) AS total_reviews
FROM Books b
LEFT JOIN Reviews r ON b.book_id = r.book_id
GROUP BY b.book_id;

-- Retrieve the details of users who have placed orders with a specific book title and have given a rating higher than 4.
SELECT u.user_id, u.name, u.email, r.rating
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Books b ON o.book_id = b.book_id
JOIN Reviews r ON u.user_id = r.user_id AND b.book_id = r.book_id
WHERE b.title = 'The Great Gatsby' AND r.rating > 4;

-- Retrieve the total revenue generated from book sales for each genre.
SELECT b.genre, SUM(o.quantity * b.price) as total_revenue
FROM Books b
JOIN Orders o ON b.book_id = o.book_id
GROUP BY b.genre;

-- Retrieve the details of users who have made payments on a specific date.
SELECT u.user_id, u.name, u.email, p.payment_amount
FROM Users u
JOIN Payments p ON u.user_id = p.user_id
WHERE p.payment_date = '2023-04-25';

-- Retrieve the details of users who have purchased books of a specific genre and paid using a specific card number.
SELECT u.user_id, u.name, u.email, b.title, p.card_number
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Books b ON o.book_id = b.book_id
JOIN PaymentDetails p ON u.user_id = p.user_id
WHERE b.genre = 'Science Fiction' AND p.card_number = '1234567890123456';

-- Retrieve the details of books that have been reviewed by users with a rating higher than 3.
SELECT b.book_id, b.title, b.author, r.review_text, r.rating
FROM Books b
JOIN Reviews r ON b.book_id = r.book_id
WHERE r.rating > 3;

-- Retrieve the details of users who have placed orders for books that are out of stock.
SELECT u.user_id, u.name, u.email, b.title
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Books b ON o.book_id = b.book_id
WHERE b.quantity = 0;

-- Retrieve the details of users who have placed orders with a total order amount higher than $100.
SELECT u.user_id, u.name, u.email, SUM(b.price * o.quantity) as total_order_amount
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Books b ON o.book_id = b.book_id
GROUP BY u.user_id
HAVING total_order_amount > 100;

-- Retrieve the details of users who have placed orders for books in a specific city.
SELECT u.user_id, u.name, u.email, o.order_id, b.title, sa.city
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Books b ON o.book_id = b.book_id
JOIN ShippingAddresses sa ON u.user_id = sa.user_id
WHERE sa.city = 'New York';

-- Retrieve the details of users who have reviewed books written by a specific author.
SELECT u.user_id, u.name, u.email, r.review_text, r.rating
FROM Users u
JOIN Reviews r ON u.user_id = r.user_id
JOIN Books b ON r.book_id = b.book_id
WHERE b.author = 'J.K. Rowling';

-- Retrieve the details of users who have purchased books with a specific status of their orders.
SELECT u.user_id, u.name, u.email, o.order_id, b.title, o.status
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Books b ON o.book_id = b.book_id
WHERE o.status = 'Delivered';

-- Retrieve the list of users who have ordered books of multiple genres:
SELECT u.name, u.email
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Books b ON o.book_id = b.book_id
GROUP BY u.user_id
HAVING COUNT(DISTINCT b.genre) > 1;

-- Retrieve the list of books that have been reviewed by a specific user:
SELECT b.title, b.author, r.rating, r.review_text
FROM Books b
JOIN Reviews r ON b.book_id = r.book_id
JOIN Users u ON r.user_id = u.user_id
WHERE u.email = 'example@example.com';

-- Retrieve the total quantity of books sold for each book, along with the book details:
SELECT b.title, b.author, SUM(o.quantity) AS total_sold
FROM Books b
JOIN Orders o ON b.book_id = o.book_id
GROUP BY b.book_id
ORDER BY total_sold DESC;

-- Retrieve the total revenue generated from completed orders, grouped by user and sorted in descending order:
SELECT u.name, SUM(o.quantity * b.price) AS revenue
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Books b ON o.book_id = b.book_id
WHERE o.status = 'Delivered'
GROUP BY u.user_id
ORDER BY revenue DESC;

-- Retrieve the total number of books sold for each genre:
SELECT genre, SUM(quantity) AS total_sold
FROM (
    SELECT Books.genre, Orders.quantity
    FROM Books
    JOIN Orders ON Books.book_id = Orders.book_id
) AS T
GROUP BY genre

-- Retrieve the name and email of all users who have placed an order for a book with a price greater than $50.00:
SELECT name, email
FROM Users
WHERE user_id IN (
    SELECT user_id
    FROM Orders
    WHERE book_id IN (
        SELECT book_id
        FROM Books
        WHERE price > 50.00
    )
)

-- Retrieve the average rating and number of reviews for each book:
SELECT title, AVG(rating) AS avg_rating, COUNT(review_id) AS num_reviews
FROM Books
LEFT JOIN (
    SELECT book_id, rating, review_id
    FROM Reviews
) AS T ON Books.book_id = T.book_id
GROUP BY Books.book_id

-- Retrieve the total revenue and number of orders for each user:
SELECT name, SUM(price * quantity) AS total_revenue, COUNT(order_id) AS num_orders
FROM Users
LEFT JOIN (
    SELECT user_id, book_id, quantity
    FROM Orders
    JOIN Books ON Orders.book_id = Books.book_id
) AS T ON Users.user_id = T.user_id
GROUP BY Users.user_id
