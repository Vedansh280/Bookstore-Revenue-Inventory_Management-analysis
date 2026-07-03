-- ==========================================
-- Bookstore Database Analysis Queries
-- ==========================================

-- 1) Retrieve all books in the "Fiction" genre
SELECT * FROM Books
WHERE Genre = 'Fiction';

-- 2) Find books published after the year 1950
SELECT * FROM Books
WHERE Published_Year > 1950;

-- 3) List all customers from Canada
SELECT * FROM Customers
WHERE Country = 'Canada';

-- 4) Show orders placed in November 2023
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available
SELECT SUM(Stock) AS total_stock_order FROM Books;

-- 6) Find the details of the most expensive book
SELECT * FROM Books
WHERE Price = (SELECT MAX(Price) FROM Books);

-- 7) Show all orders where quantity ordered is more than 1
SELECT * FROM Orders
WHERE Quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20
SELECT * FROM Orders
WHERE Total_Amount > 20;

-- 9) Calculate total revenue generated from all orders
SELECT SUM(Total_Amount) AS total_revenue FROM Orders;

-- 10) Find the book with the lowest stock
SELECT * FROM Books
WHERE Stock = (SELECT MIN(Stock) FROM Books);

-- 11) Calculate the total revenue generated from all orders
SELECT SUM(Total_Amount) AS total_revenue FROM Orders;

-- 12) Retrieve the total number of books sold for each genre
SELECT b.Genre, SUM(o.Quantity) AS total_sales_by_genre
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre
ORDER BY total_sales_by_genre DESC;

-- 13) Find the average price of books in the "Fantasy" genre
SELECT AVG(Price) AS avg_price_fantasy
FROM Books
WHERE Genre = 'Fantasy';

-- 14) List orders where quantity ordered is more than 1, with customer details
SELECT o.Order_ID, o.Customer_ID, c.Name, o.Quantity
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Quantity > 1;

-- 15) Find the most frequently ordered book (by max single-order quantity)
SELECT b.Book_ID, b.Title, b.Author, b.Published_Year, b.Price, b.Stock,
       o.Quantity, o.Order_Date, o.Total_Amount
FROM Books b
JOIN Orders o ON b.Book_ID = o.Book_ID
WHERE o.Quantity = (SELECT MAX(Quantity) FROM Orders);

-- 16) Show the top 3 most expensive books in the 'Fantasy' genre
SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- 17) Retrieve the total quantity of books sold by each author
SELECT b.Author, SUM(o.Quantity) AS total_quantity
FROM Books b
JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Author
ORDER BY total_quantity DESC;

-- 18) List the cities where customers who spent over $30 (total) are located
SELECT DISTINCT c.City, SUM(o.Total_Amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.City
HAVING SUM(o.Total_Amount) > 30
ORDER BY total_spent DESC;

-- 19) Find the customer who spent the most on orders
SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS total_spent
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY total_spent DESC
LIMIT 1;

-- 20) Calculate the stock remaining after fulfilling all orders
SELECT b.Book_ID, b.Title, b.Stock,
       COALESCE(SUM(o.Quantity), 0) AS total_ordered,
       b.Stock - COALESCE(SUM(o.Quantity), 0) AS remaining_stock
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
ORDER BY remaining_stock;
