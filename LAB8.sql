-- lab 08 https://github.com/MicrosoftLearning/QueryingT-SQL/blob/master/Labs/Lab08.pdf


-- EXAMPLE
SELECT cat.ParentProductCategoryName, cat.ProductCategoryName, count(prd.ProductID) AS Products
FROM SalesLT.vGetAllCategories as cat
LEFT JOIN SalesLT.Product AS prd
ON prd.ProductCategoryID = cat.ProductcategoryID
--GROUP BY cat.ParentProductCategoryName, cat.ProductCategoryName
-- GROUP BY GROUPING SETS(cat.ParentProductCategoryName, cat.ProductCategoryName, ())
--GROUP BY ROLLUP (cat.ParentProductCategoryName, cat.ProductCategoryName)
--GROUP BY CUBE (cat.ParentProductCategoryName, cat.ProductCategoryName)
ORDER BY cat.ParentProductCategoryName, cat.ProductCategoryName;







-- challenge 1
-- 1
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) as revenue
from saleslt.address as a
join saleslt.customeraddress as ca on a.addressid = ca.addressid 
join saleslt.customer as c on ca.customerid = c.customerid
join saleslt.salesorderheader as soh on c.customerid = soh.customerid
group by ROLLUP(a.CountryRegion, a.StateProvince)
order by a.CountryRegion, a.StateProvince;
-- 2
SELECT a.CountryRegion, a.StateProvince,
IIF(GROUPING_ID(a.CountryRegion) = 1 AND GROUPING_ID(a.StateProvince) = 1, 'Total', IIF(GROUPING_ID(a.StateProvince) = 1, a.CountryRegion + ' Subtotal', a.StateProvince + ' Subtotal')) AS Level,
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;
-- 3
SELECT a.CountryRegion, a.StateProvince, a.City,
CHOOSE (1 + GROUPING_ID(a.CountryRegion) + GROUPING_ID(a.StateProvince) + GROUPING_ID(a.City), a.City + ' Subtotal1', a.StateProvince + ' Subtotal2', a.CountryRegion + ' Subtotal3', 'Total') AS Level,
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince, a.City)
ORDER BY a.CountryRegion, a.StateProvince, a.City;

-- challenge 2
-- 1

SELECT * FROM SALESLT.CUSTOMER;
SELECT * FROM SALESLT.SALESORDERHEADER;
SELECT * FROM SALESLT.SALESORDERDETAIL;
SELECT * FROM SALESLT.PRODUCT;
SELECT * FROM SALESLT.PRODUCTCATEGORY;



SELECT cat.ParentProductCategoryName, cust.CompanyName, sod.LineTotal
 FROM SalesLT.SalesOrderDetail AS sod
 JOIN SalesLT.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
 JOIN SalesLT.Customer AS cust ON soh.CustomerID = cust.CustomerID
 JOIN SalesLT.Product AS prod ON sod.ProductID = prod.ProductID
 JOIN SalesLT.vGetAllCategories AS cat ON prod.ProductcategoryID = cat.ProductCategoryID;



 CREATE TABLE #TESTPIVOT1
(CompanyName varchar(50), Accessories varchar(50),Bikes varchar(50), Clothing varchar(50), Components int);

INSERT INTO #TESTPIVOT1
SELECT * FROM
(SELECT cat.ParentProductCategoryName, cust.CompanyName, sod.LineTotal
 FROM SalesLT.SalesOrderDetail AS sod
 JOIN SalesLT.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
 JOIN SalesLT.Customer AS cust ON soh.CustomerID = cust.CustomerID
 JOIN SalesLT.Product AS prod ON sod.ProductID = prod.ProductID
 JOIN SalesLT.vGetAllCategories AS cat ON prod.ProductcategoryID = cat.ProductCategoryID) AS catsales
PIVOT (SUM(LineTotal) FOR ParentProductCategoryName IN ([Accessories], [Bikes], [Clothing], [Components])) AS pivotedsales
ORDER BY CompanyName;


SELECT CompanyName, Color, SumTotal
FROM
(SELECT CompanyName,
[Accessories], [Bikes], [Clothing], [Components]
FROM #TESTPIVOT1) pcp
UNPIVOT
(SumTotal FOR Color IN ([Accessories], [Bikes], [Clothing])
) AS SumTotals
