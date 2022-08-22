#Northwind Database Exercises-

#Write a query to get Product name and quantity/unit
SELECT ProductName, QuantityPerUnit 
FROM Products;

#Write a query to get current Product list (Product ID and name)
SELECT ProductID, ProductName
FROM Products
WHERE Discontinued = "False"
ORDER BY ProductName;

#Write a query to get discontinued Product list (Product ID and name).
SELECT ProductID, ProductName
FROM Products
WHERE Discontinued = 1
ORDER BY ProductName;

#Write a query to get most expense and least expensive Product list (name and unit price
SELECT ProductName, UnitPrice 
FROM Products 
ORDER BY UnitPrice DESC;

#Write a query to get Product list (id, name, unit price) where current products cost less than $20
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE (((UnitPrice)<20) AND ((Discontinued)=False))
ORDER BY UnitPrice DESC;

#Write a query to get Product list (name, unit price) where products cost between $15 and $25.
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 15.0000 AND 25.0000

#Write a query to get Product list (name, unit price) of above average price
SELECT DISTINCT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT avg(UnitPrice) FROM Products)
ORDER BY UnitPrice;

#Write a query to get Product list (name, unit price) of ten most expensive products
SELECT DISTINCT ProductName as Twenty_Most_Expensive_Products, UnitPrice
FROM Products AS a
WHERE 20 >= (SELECT COUNT(DISTINCT UnitPrice)
                    FROM Products AS b
                    WHERE b.UnitPrice >= a.UnitPrice)
ORDER BY UnitPrice desc;

#Write a query to count current and discontinued products
SELECT Count(ProductName)
FROM Products
GROUP BY Discontinued;

#Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order
SELECT ProductName,  UnitsOnOrder , UnitsInStock
FROM Products
WHERE (((Discontinued)=False) AND ((UnitsInStock)<UnitsOnOrder));

