SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.Customer

SELECT 
    st.Name AS RegionName,
    COUNT(DISTINCT c.CustomerID) AS UniqueCustomers,
    CAST(SUM(soh.TotalDue) AS decimal(18,2)) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
GROUP BY st.Name
ORDER BY TotalSales DESC;