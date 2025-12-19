SELECT * FROM Production.Product
SELECT * FROM Sales.SalesOrderDetail


SELECT TOP 10
    p.Name AS ProduktNamn,
    SUM(sod.LineTotal) AS Försäljningsvärde,
    SUM(sod.OrderQty) AS AntalSåldaProdukter
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY Försäljningsvärde DESC;
