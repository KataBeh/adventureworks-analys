-- Vilken region presterar bäst/sämst?

SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.SalesOrderHeader

SELECT 
    st.Name AS RegionName,
    CAST(SUM(soh.TotalDue) AS decimal(18,2)) AS TotalSales,
    COUNT(DISTINCT soh.SalesOrderID) AS NumberOfOrders,
    COUNT(DISTINCT soh.CustomerID) AS UniqueCustomers,
    CAST(
        SUM(soh.TotalDue) / NULLIF(COUNT(DISTINCT soh.SalesOrderID), 0)
        AS decimal(18,2)
    ) AS AvgOrderValue
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY TotalSales DESC;


-- Vilka produktkategorier säljer bäst var?

SELECT 
    st.Name AS Region,
    pc.Name AS Category,
    SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY st.Name, pc.Name
ORDER BY TotalSales DESC;