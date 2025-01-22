
# Pawfect Pet Supplies Inventory and Sales Tracker

## Create Database:
```sql
CREATE DATABASE PawfectPetSupplies;
```

### Explanation:
- This command creates a new database named PawfectPetSupplies to store all the tables and data related to the pet store.

## Use Database:
```sql
USE PawfectPetSupplies;
```

### Explanation:
- This command selects the PawfectPetSupplies database as the active database so that all subsequent SQL operations, such as creating tables or inserting data, are performed within it.

These commands set up and prepare the environment for building the pet store's database.

## Database Design

### Table: Customers
The Customers table stores essential information about the store’s customers. It includes fields for a unique CustomerID, first name, surname, and email address. The CustomerID acts as a primary key, ensuring that each customer record is uniquely identifiable and enabling efficient data retrieval.

```sql
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    Surname VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL
);
```

### Explanation:
- **CustomerID**: A unique identifier for each customer, automatically generated using the AUTO_INCREMENT feature. This is the table’s primary key.
- **FirstName** and **Surname**: These fields store the customer’s first name and surname, respectively. Both are required fields (NOT NULL) to ensure complete customer records.
- **Email**: Stores the customer's email address, which is required (NOT NULL) and must be unique to prevent duplicate or conflicting records.

This table is designed to store customer information efficiently while maintaining data integrity through constraints on unique and required fields.

### Table: Categories
The Categories table is designed to organize products into distinct groups, making it easier to manage and retrieve related items. The CategoryID serves as the primary key, ensuring each category is uniquely identifiable.

```sql
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);
```

### Explanation:
- **CategoryID**: A unique identifier for each product category, automatically generated using the AUTO_INCREMENT feature. This serves as the table's primary key.
- **CategoryName**: Stores the name of the category, which is required (NOT NULL) to ensure that each category is clearly defined.

This table is designed to store product categories efficiently, with a primary key to maintain data integrity and ensure each category is unique.

### Table: Products
The Products table is used to store detailed information about the products available in the store. It includes fields like ProductID, ProductName, CategoryID, and Price, where ProductID serves as the unique identifier and CategoryID links each product to a specific category. This structure ensures that product information is well-organized and easily accessible.

```sql
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    CategoryID INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0),
    StockQuantity INT DEFAULT 0 CHECK (StockQuantity >= 0),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
```

### Explanation:
- **ProductID**: A unique identifier for each product, automatically generated using the AUTO_INCREMENT feature. This serves as the table's primary key.
- **ProductName**: Stores the name of the product, which is required (NOT NULL) to provide a clear identification of each item.
- **CategoryID**: Links each product to a specific category, serving as a foreign key that references the CategoryID in the Categories table.
- **Price**: Stores the price of the product, which is required (NOT NULL) to ensure the cost is specified for each item.
- **StockQuantity**: This field holds the number of items in stock for each product. The default value is set to 0, and you can update it as you manage inventory.

This table is designed to efficiently store product details, ensuring data integrity through unique identifiers and foreign key relationships.

### Table: Sales
The Sales table tracks individual sales transactions, capturing information about each sale made in the store. It includes fields like SaleID, CustomerID, SaleDate, and TotalAmount, where SaleID serves as the unique identifier for each transaction. This table allows for efficient tracking and analysis of sales activities, linked to specific customers and transactions.

```sql
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    SaleDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```

### Explanation:
- **SaleID**: A unique identifier for each sale, automatically generated using the AUTO_INCREMENT feature. This serves as the table's primary key.
- **CustomerID**: Links each sale to a specific customer, serving as a foreign key that references the CustomerID in the Customers table.
- **SaleDate**: Stores the date of the sale, which is required (NOT NULL) to track when each transaction occurred.
- **TotalAmount**: Stores the total amount of the sale, which is required (NOT NULL) to represent the total cost of the transaction.

This table is designed to efficiently track sales transactions, ensuring each sale is linked to a customer and includes key details for analysis.

### Table: Orders
The Orders table tracks details about the individual items purchased in each sale. It includes fields for a unique OrderID, the SaleID linking to the sale, the ProductID linking to the product sold, and the Quantity of the product sold in the order. The table establishes relationships between sales and products, enabling detailed analysis of product performance.

```sql
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    SaleID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```

### Explanation:
- **OrderID**: A unique identifier for each order record, automatically generated using the AUTO_INCREMENT feature. This serves as the table’s primary key.
- **SaleID**: A foreign key referencing the Sales table, linking each order to a specific sale.
- **ProductID**: A foreign key referencing the Products table, connecting each order to the corresponding product sold.
- **Quantity**: An integer field indicating the number of units of the product sold in the order. This field helps track the volume of products sold per transaction.

This table allows detailed tracking of which products are sold in each sale, enabling analysis of best-selling products and inventory management.

## Populating the Data

### Data Population: Categories
```sql
INSERT INTO Categories (CategoryName) VALUES
    ('Pet Food'),
    ('Toys'),
    ('Grooming Supplies'),
    ('Accessories');
```

### Data Population: Products
```sql
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
```

### Data Population: Customers
```sql
INSERT INTO Customers (FirstName, Surname, Email) VALUES
    ('Juan', 'Gomez', 'juan.gomez@example.com'),
    ('Amina', 'Ahmed', 'amina.ahmed@example.com'),
    ('Liu', 'Wei', 'liu.wei@example.com'),
    ('Sofia', 'Nielsen', 'sofia.nielsen@example.com'),
    ('Kwame', 'Osei', 'kwame.osei@example.com'),
    ('Maya', 'Patel', 'maya.patel@example.com'),
    ('Olivia', 'Smith', 'olivia.smith@example.com');
```

### Data Population: Sales
```sql
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
```

### Data Population: Orders
```sql
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
```

## Queries for Analysis

### Displaying all products with their prices and stock quantities
```sql
SELECT ProductName, Price, StockQuantity
FROM Products;
```

### Identifying products low in stock
```sql
SELECT ProductName, StockQuantity
FROM Products
WHERE StockQuantity < 5;
```

### Calculating the total revenue generated from sales
```sql
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Sales;
```

### Listing the top three best-selling products
```sql
SELECT Products.ProductName,
    SUM(Orders.Quantity) AS TotalSold
FROM Orders
JOIN Products ON Orders.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalSold DESC
LIMIT 3;
```

### Showing all purchases made by a specific customer using CustomerID
```sql
SELECT Sales.SaleID, Sales.SaleDate, Products.ProductName, Orders.Quantity, Products.Price, (Orders.Quantity * Products.Price) AS TotalPrice
FROM Sales
JOIN Orders ON Sales.SaleID = Orders.SaleID
JOIN Products ON Orders.ProductID = Products.ProductID
WHERE Sales.CustomerID = 1;
```

### Calculating the total number of products sold in each category
```sql
SELECT Categories.CategoryName,
    SUM(Orders.Quantity) AS TotalSold
FROM Orders
JOIN Products ON Orders.ProductID = Products.ProductID
JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryName
ORDER BY TotalSold DESC;
```
