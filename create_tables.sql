-- ==========================================
-- Bookstore Database Schema
-- ==========================================

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(50),
    Author VARCHAR(50),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10,2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(50)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10,2)
);

-- ==========================================
-- Data cleanup: remove orphan rows before
-- adding foreign key constraints
-- ==========================================

DELETE FROM Orders
WHERE Customer_ID NOT IN (SELECT Customer_ID FROM Customers);

DELETE FROM Orders
WHERE Book_ID NOT IN (SELECT Book_ID FROM Books);

-- ==========================================
-- Foreign key constraints
-- ==========================================

ALTER TABLE Orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID);

ALTER TABLE Orders
ADD CONSTRAINT fk_orders_book
FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID);
