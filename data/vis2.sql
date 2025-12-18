SELECT * FROM Production.ProductCategory
SELECT * FROM Production.ProductSubcategory
SELECT * FROM Production.Product
SELECT * FROM Sales.SalesOrderDetail


SELECT
    pc.Name AS CategoryName,
    SUM (sod.OrderQty * sod.UnitPrice) AS TotalOmsättning
FROM Production.ProductCategory pc 
INNER JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID = psc.ProductCategoryID
INNER JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID

GROUP BY pc.Name
ORDER BY TotalOmsättning DESC;



-- testar med LineTotal (det faktiska beloppet för orderraden)

SELECT
    pc.Name AS CategoryName,
    SUM (sod.LineTotal) AS TotalOmsättning
FROM Production.ProductCategory pc 
INNER JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID = psc.ProductCategoryID
INNER JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID

GROUP BY pc.Name
ORDER BY TotalOmsättning DESC;



-- snyggar till koden lite för att visa med 2 decimaler:

SELECT
    pc.Name AS CategoryName,
    CAST(SUM (sod.LineTotal) AS decimal(18,2)) AS TotalOmsättning
FROM Production.ProductCategory pc 
INNER JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID = psc.ProductCategoryID
INNER JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID

GROUP BY pc.Name
ORDER BY TotalOmsättning DESC;