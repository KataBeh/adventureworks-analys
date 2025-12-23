SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.Customer
SELECT * FROM Sales.Store 



SELECT
  SUM(CASE WHEN StoreID IS NOT NULL THEN 1 ELSE 0 END) AS StoreCustomers,
  SUM(CASE WHEN PersonID IS NOT NULL THEN 1 ELSE 0 END) AS IndividualCustomers
FROM Sales.Customer;




SELECT TOP 20
  c.CustomerID, c.StoreID, COUNT(*) AS Orders
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
WHERE c.StoreID IS NOT NULL
GROUP BY c.CustomerID, c.StoreID
ORDER BY Orders DESC;



SELECT TOP 20
  c.CustomerID, c.PersonID, c.StoreID
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
WHERE c.StoreID IS NOT NULL AND c.PersonID IS NOT NULL;




-- Sammanställer försäljning och orderstatistik per region och kundtyp:
;WITH SalesByRegionAndCustomerType AS (
    SELECT 
        st.Name AS RegionName,
        CASE
            WHEN c.StoreID IS NOT NULL THEN 'Store'
            WHEN c.PersonID IS NOT NULL THEN 'Individual'
            ELSE 'Unknow Customer Type'
    END AS CustomerType,
    COUNT(DISTINCT soh.SalesOrderID) AS NumberOfOrders,
    SUM(soh.TotalDue) AS TotalSales,
    SUM(TotalDue) / NULLIF(COUNT (DISTINCT soh.SalesOrderID), 0) AS AvgOrderValue

FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
LEFT JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID

GROUP BY st.Name,
 CASE
        WHEN c.StoreID IS NOT NULL THEN 'Store'
        WHEN c.PersonID IS NOT NULL THEN 'Individual'
        ELSE 'Unknow Customer Type'
    END
),

RegionRank AS (
    SELECT
        RegionName,
        SUM(TotalSales) / NULLIF(SUM(NumberOfOrders), 0) AS AvgOrderValue_Total
    FROM SalesByRegionAndCustomerType  
    GROUP BY RegionName
)

SELECT
    srct.RegionName,
    srct.CustomerType,
    CAST(srct.TotalSales AS decimal(18,2)) AS TotalSales,
    srct.NumberOfOrders,
    CAST(srct.AvgOrderValue AS decimal(18,2)) AS AvgOrderValue

FROM SalesByRegionAndCustomerType srct  
JOIN RegionRank r ON srct.RegionName = r.RegionName

ORDER BY 
    r.AvgOrderValue_Total DESC,
    srct.CustomerType ASC;
