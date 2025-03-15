-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255),
    CreatedAt DATE
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 1. Retrieve all customers who placed an order in the last 30 days
SELECT DISTINCT c.CustomerID, c.Name, c.Email, c.Phone, c.Address
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= CURDATE() - INTERVAL 30 DAY;

-- 2. Find the total revenue generated from each product category.
SELECT p.Category, SUM(od.Quantity * od.Price) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Category;

-- 3. Identify customers who have never placed an order
SELECT c.CustomerID, c.Name, c.Email, c.Phone, c.Address
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- 4. List the top 5 best-selling products
SELECT p.ProductName, SUM(od.Quantity) AS TotalSold
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSold DESC
LIMIT 5;

-- 5. Find the customer who has spent the most money
SELECT c.CustomerID, c.Name, SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalSpent DESC
LIMIT 1;

-- 6. Retrieve the average order value for each month in the past year
SELECT YEAR(o.OrderDate) AS Year, MONTH(o.OrderDate) AS Month,
       AVG(o.TotalAmount) AS AverageOrderValue
FROM Orders o
WHERE o.OrderDate >= CURDATE() - INTERVAL 1 YEAR
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY Year DESC, Month DESC;

-- 7. Find products with stock quantity less than 10 and need restocking
SELECT ProductID, ProductName, StockQuantity
FROM Products
WHERE StockQuantity < 10;

-- 8. Show all orders where the total amount is above the average order value
SELECT o.OrderID, o.CustomerID, o.TotalAmount
FROM Orders o
WHERE o.TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);

-- 9. List all customers who made their first order in the last 6 months
SELECT c.CustomerID, c.Name, c.Email, c.Phone
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
HAVING MIN(o.OrderDate) >= CURDATE() - INTERVAL 6 MONTH;

-- 10.  Find the total sales amount for each customer in descending order
SELECT c.CustomerID, c.Name, SUM(o.TotalAmount) AS TotalSales
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalSales DESC;





