SELECT * FROM Sales.SalesOrderHeader


SELECT 
    YEAR(OrderDate) AS OrderYear,
    CAST(SUM(TotalDue) AS decimal(18,2)) AS TotalSales,
    COUNT(SalesOrderID) AS AntalOrdar
FROM Sales.SalesOrderHeader
GROUP BY
    YEAR(OrderDate)
ORDER BY
    OrderYear ASC;

-- År 2025 lägre än 2024 (ofullständigt data fram till juni), vilket förklarar lägre totalsiffror

SELECT COUNT(*) FROM Sales.SalesOrderHeader -- dubbelkollar bara så att 1692 + 3830 + 14244 + 11699 ger rätt summa tillsammans