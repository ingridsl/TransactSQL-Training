-- lab01 https://github.com/MicrosoftLearning/QueryingT-SQL/blob/master/Labs/Lab01.pdf

-- CHALLENGE 1
-- 1
SELECT * FROM SALESLT.Customer;
-- 2
SELECT SALESLT.CUSTOMER.Title, SalesLT.Customer.FirstName, SalesLT.Customer.MiddleName, SalesLT.Customer.LastName, SalesLT.Customer.Suffix
FROM SALESLT.Customer;
-- 3
SELECT SALESLT.Customer.SalesPerson, SalesLT.Customer.TITLE + ' ' + SalesLT.Customer.LastName AS CUSTOMERNAME, SALESLT.Customer.PHONE
FROM SALESLT.CUSTOMER;

-- CHALLENGE 2
-- 1
SELECT CAST(SALESLT.CUSTOMER.CUSTOMERID AS VARCHAR) + ':' + SALESLT.CUSTOMER.COMPANYNAME AS CUSTOMERCOMPANY
FROM SALESLT.CUSTOMER;
-- 2
SELECT 'SO' + CAST(SALESORDERID AS VARCHAR(5))  + ' (' + STR(RevisionNumber, 1) + ')' AS OrderRevision,
 CONVERT(NVARCHAR(10), ORDERDATE, 102) AS ISO8601FORMATDATE
FROM SALESLT.SALESORDERHEADER;

--CHALLENGE 3
-- 1
SELECT FIRSTNAME + ' ' + ISNULL(MIDDLENAME + ' ', '')  + LASTNAME AS FULLNAME
FROM SALESLT.CUSTOMER;
-- 2
UPDATE SALESLT.CUSTOMER
SET EMAILADDRESS = NULL
WHERE CUSTOMERID % 7 = 1;

SELECT CUSTOMERID, COALESCE(EMAILADDRESS, PHONE) AS PRIMARYCONTACT
FROM SALESLT.CUSTOMER;
-- 3

SELECT * FROM SALESLT.SALESORDERHEADER;
UPDATE SALESLT.SALESORDERHEADER
SET SHIPDATE = NULL
WHERE SALESORDERID > 71899;

SELECT SALESORDERID, ORDERDATE,
		CASE 
			WHEN SHIPDATE IS NULL THEN 'AWAITING SHIPMENT'
			ELSE 'SHIPPED'
		END AS SHIPPINGSTATUS
FROM SALESLT.SALESORDERHEADER;