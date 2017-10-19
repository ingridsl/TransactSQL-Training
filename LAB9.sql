-- lab 09 https://github.com/MicrosoftLearning/QueryingT-SQL/blob/master/Labs/Lab09.pdf
-- challenge 01
-- 1
SELECT * FROM SALESLT.PRODUCT;
SELECT * FROM SALESLT.PRODUCTCATEGORY;

INSERT INTO SALESLT.PRODUCT (NAME, PRODUCTNUMBER, STANDARDCOST, LISTPRICE, PRODUCTCATEGORYID, SELLSTARTDATE)
VALUES ('LED LIGHTS', 'LT-123', 2.56, 12.99, 37, GETDATE());

SELECT SCOPE_IDENTITY();

SELECT * FROM SalesLT.Product
WHERE ProductID = SCOPE_IDENTITY();
-- 2
INSERT INTO SalesLT.ProductCategory (ParentProductCategoryID, Name)
VALUES
(4, 'Bells and Horns');

INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
('Bicycle Bell', 'BB-RING', 2.47, 4.99, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE()),
('Bicycle Horn', 'BH-PARP', 1.29, 3.75, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE());

SELECT C.NAME AS CATEGORY, P.NAME AS PRODUCT
FROM SALESLT.PRODUCT AS P
JOIN SALESLT.PRODUCTCATEGORY AS C
ON C.ProductCategoryID = P.ProductCategoryID
WHERE P.ProductCategoryID = IDENT_CURRENT('SALESLT.PRODUCTCATEGORY');
-- challenge 02
-- 1
UPDATE SALESLT.PRODUCT
SET LISTPRICE = LISTPRICE * 1.1
WHERE ProductCategoryID = (SELECT ProductCategoryID FROM SALESLT.ProductCategory WHERE NAME = 'Bells and Horns');
-- 2
UPDATE SALESLT.PRODUCT
SET DISCONTINUEDDATE = GETDATE()
WHERE ProductCategoryID = 37 AND NAME <>  'LT-L123';
-- challenge 03
-- 1
DELETE FROM SALESLT.PRODUCT
WHERE ProductCategoryID = (SELECT ProductCategoryID FROM SALESLT.ProductCategory WHERE NAME = 'Bells and Horns');

DELETE FROM SALESLT.PRODUCTCATEGORY
WHERE ProductCategoryID = (SELECT ProductCategoryID FROM SALESLT.ProductCategory WHERE NAME = 'Bells and Horns');
