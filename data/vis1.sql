USE AdventureWorks2025

SELECT * FROM Production.ProductCategory
SELECT * FROM Production.ProductSubcategory
SELECT * FROM Production.Product


SELECT
    pc.Name AS CategoryName,
    COUNT (DISTINCT p.ProductID) AS ProductCount
FROM Production.ProductCategory pc 
INNER JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID = psc.ProductCategoryID
LEFT JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY pc.Name
ORDER BY ProductCount DESC



SELECT
    pc.Name AS CategoryName,
    psc.Name AS SubcategoryName,
    COUNT (DISTINCT p.ProductID) AS ProductCount
FROM Production.ProductCategory pc 
INNER JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID = psc.ProductCategoryID
LEFT JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
WHERE pc.Name = 'Bikes'
GROUP BY pc.Name, psc.Name
ORDER BY ProductCount DESC


SELECT
    pc.Name AS CategoryName,
    psc.Name AS SubcategoryName,
    COUNT (DISTINCT p.ProductID) AS ProductCount
FROM Production.ProductCategory pc 
INNER JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID = psc.ProductCategoryID
LEFT JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
WHERE pc.Name = 'Clothing'
GROUP BY pc.Name, psc.Name
ORDER BY ProductCount DESC