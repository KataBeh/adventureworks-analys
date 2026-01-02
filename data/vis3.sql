SELECT * FROM Sales.SalesOrderHeader

SELECT
    MIN(OrderDate) AS MinDate,
    MAX(OrderDate) AS MaxDate
FROM Sales.SalesOrderHeader;

SELECT 
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE 
    OrderDate >= DATEADD(MONTH, -12, GETDATE())
GROUP BY
    YEAR(OrderDate),
    MONTH(OrderDate)
ORDER BY
    OrderYear ASC,
    OrderMonth ASC;


-- Försöker ändra format på datum, det blir lättare att läsa:

SELECT 
    FORMAT(OrderDate, 'yyyy-MM') AS YearMonth,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE 
    OrderDate >= (
        SELECT DATEADD(MONTH, -12, MAX(OrderDate))
        FROM Sales.SalesOrderHeader
    )
GROUP BY
    FORMAT(OrderDate, 'yyyy-MM')
ORDER BY
    YearMonth ASC;


-- Hade kunnat snygga upp med att få TotalSales lite mer läsbar

SELECT 
    FORMAT(OrderDate, 'yyyy-MM') AS YearMonth,
    CAST(SUM(TotalDue) AS decimal(18,2)) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE 
    OrderDate >= (
        SELECT DATEADD(MONTH, -12, MAX(OrderDate))
        FROM Sales.SalesOrderHeader
    )
GROUP BY
    FORMAT(OrderDate, 'yyyy-MM')
ORDER BY
    YearMonth ASC;