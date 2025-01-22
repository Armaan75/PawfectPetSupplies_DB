-- ! Creates the database
CREATE DATABASE PawfectPetSupplies;

-- ! Selects the database
USE PawfectPetSupplies;

-- * Creating Tables

-- Creates customer table to store customer details
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    Surname VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL
);

-- Creates categories table to store categories details
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

-- Creates products table to store product details
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    CategoryID INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0),
    StockQuantity INT DEFAULT 0 CHECK (StockQuantity >= 0),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Creates sales table to store sale details
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    SaleDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Creates orders table to store order details
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    SaleID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- * Populating the Data

-- Inserting values onto the categories table
INSERT INTO Categories (CategoryName) VALUES
('Pet Food'),
('Toys'),
('Grooming Supplies'),
('Accessories');

-- Inserting values onto the products table
INSERT INTO Products (ProductName, Price, CategoryID, StockQuantity) VALUES
('Dog Food', 15.99, 1, 50),
('Cat Food', 12.99, 1, 30),
('Chew Toy', 5.99, 2, 20),
('Cat Toy', 7.49, 2, 15),
('Dog Leash', 10.99, 3, 40),
('Dog Collar', 8.99, 3, 25),
('Shampoo', 14.99, 4, 60),
('Conditioner', 12.99, 4, 35),
('Dog Bowl', 6.49, 3, 100),
('Cat Litter', 11.99, 1, 45);

-- Inserting values onto the customers table
INSERT INTO Customers (FirstName, Surname, Email) VALUES
('Juan', 'Gomez', 'juan.gomez@example.com'),
('Amina', 'Ahmed', 'amina.ahmed@example.com'),
('Liu', 'Wei', 'liu.wei@example.com'),
('Sofia', 'Nielsen', 'sofia.nielsen@example.com'),
('Kwame', 'Osei', 'kwame.osei@example.com'),
('Maya', 'Patel', 'maya.patel@example.com'),
('Olivia', 'Smith', 'olivia.smith@example.com');

-- Inserting values onto the sales table
INSERT INTO Sales (CustomerID, SaleDate, TotalAmount) VALUES
(1, '2025-01-01', 25.98),
(2, '2025-01-02', 38.47),
(3, '2025-01-03', 18.98),
(4, '2025-01-04', 48.49),
(5, '2025-01-05', 15.98),
(6, '2025-01-06', 39.98),
(7, '2025-01-07', 33.48),
(1, '2025-01-08', 22.49),
(2, '2025-01-09', 54.97),
(3, '2025-01-10', 28.97),
(4, '2025-01-11', 45.89),
(5, '2025-01-12', 19.99),
(6, '2025-01-13', 25.98),
(7, '2025-01-14', 35.98),
(1, '2025-01-15', 29.99);

-- Inserting values onto the orders table
INSERT INTO Orders (SaleID, ProductID, Quantity) VALUES
(1, 3, 2),
(1, 5, 1),
(2, 2, 4),
(3, 4, 1),
(3, 1, 3),
(4, 6, 2),
(5, 7, 1),
(6, 3, 5),
(7, 8, 2),
(8, 9, 1),
(9, 10, 3),
(10, 1, 2),
(11, 5, 4),
(12, 4, 1);

-- * Queries for Analysis

-- Displaying all products with prices and stock quantity
SELECT ProductName, Price, StockQuantity
FROM Products;

-- Identifying products low in stock
SELECT ProductName, StockQuantity
FROM Products
WHERE StockQuantity < 5;

-- Calculating total revenue generated from sales
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Sales;

-- Listing top 3 best-selling products
SELECT Products.ProductName,
SUM(Orders.Quantity) AS TotalSold
FROM Orders
JOIN Products ON Orders.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalSold DESC
LIMIT 3;

-- Displaying all purchases made by a specific customer using CustomerID
SELECT Sales.SaleID, Sales.SaleDate, Products.ProductName, Orders.Quantity, Products.Price, (Orders.Quantity * Products.Price) AS TotalPrice
FROM Sales
JOIN Orders ON Sales.SaleID = Orders.SaleID
JOIN Products ON Orders.ProductID = Products.ProductID
WHERE Sales.CustomerID = 1;

-- Calculating the total number of products sold in each category
SELECT Categories.CategoryName,
SUM(Orders.Quantity) AS TotalSold
FROM Orders
JOIN Products ON Orders.ProductID = Products.ProductID
JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryName
ORDER BY TotalSold DESC;