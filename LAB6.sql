-- lab 6 https://github.com/MicrosoftLearning/QueryingT-SQL/blob/master/Labs/Lab06.pdf
-- challenge 1
-- 1
SELECT * FROM SALESLT.PRODUCT;
SELECT * FROM SALESLT.SALESORDERHEADER;
SELECT * FROM SALESLT.SALESORDERDETAIL;

SELECT P.PRODUCTID, P.NAME, P.LISTPRICE
FROM SALESLT.PRODUCT AS P
WHERE P.LISTPRICE > (
	SELECT AVG(S.UNITPRICE) AS AVGPRICE
	FROM SALESLT.SALESORDERDETAIL AS S
	JOIN SALESLT.PRODUCT
	ON P.PRODUCTID = S.PRODUCTID

)ORDER BY P.PRODUCTID;


-- 2
SELECT P.PRODUCTID, P.NAME, P.LISTPRICE
FROM SALESLT.PRODUCT AS P
WHERE P.ProductID  IN (
	SELECT S.PRODUCTID
	FROM SALESLT.SALESORDERDETAIL AS S
	WHERE S.UNITPRICE < 100	
) AND P.LISTPRICE >= 100
ORDER BY P.PRODUCTID;

-- 3
SELECT P.PRODUCTID, P.NAME, P.STANDARDCOST AS COST, P.LISTPRICE,
	(SELECT AVG(S.UNITPRICE)
	FROM SALESLT.SALESORDERDETAIL AS S
	WHERE P.PRODUCTID = S.PRODUCTID ) AS AVGSELPRICE
FROM SALESLT.PRODUCT AS P
ORDER BY P.PRODUCTID;


-- 4
SELECT P.PRODUCTID, P.NAME, P.STANDARDCOST AS COST, P.LISTPRICE,
	(SELECT AVG(S.UNITPRICE)
	FROM SALESLT.SALESORDERDETAIL AS S
	WHERE P.PRODUCTID = S.PRODUCTID ) AS AVGSELPRICE
FROM SALESLT.PRODUCT AS P
WHERE P.STANDARDCOST > (SELECT AVG(S.UNITPRICE)
	FROM SALESLT.SALESORDERDETAIL AS S
	WHERE P.PRODUCTID = S.PRODUCTID ) 
ORDER BY P.PRODUCTID;


-- challenge 2
-- 1
SELECT * FROM SALESLT.SALESORDERHEADER;
SELECT * FROM SALESLT.CUSTOMER;
SELECT S.SALESORDERID, C.CUSTOMERID, C.FIRSTNAME, C.LASTNAME, S.TOTALDUE
FROM SALESLT.SALESORDERHEADER AS S
CROSS APPLY dbo.ufnGetCustomerInformation(S.CUSTOMERID) AS C
ORDER BY S.SALESORDERID;

-- 2
SELECT * FROM SALESLT.CUSTOMER;
SELECT * FROM SALESLT.ADDRESS;
SELECT * FROM SALESLT.CUSTOMERADDRESS;

SELECT C.CUSTOMERID, C.FIRSTNAME, C.LASTNAME, A.ADDRESSLINE1, A.CITY
FROM SALESLT.CUSTOMERADDRESS AS CA
JOIN SALESLT.ADDRESS AS A
ON A.ADDRESSID = CA.ADDRESSID
CROSS APPLY dbo.ufnGetCustomerInformation(CA.CUSTOMERID) AS C
ORDER BY CA.CUSTOMERID;