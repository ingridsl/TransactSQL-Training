-- lab 10 https://github.com/MicrosoftLearning/QueryingT-SQL/blob/master/Labs/Lab10.pdf
-- challenge 1
	SELECT * FROM SALESLT.SalesOrderDetail;
	SELECT * FROM SALESLT.SalesOrderHeader;
-- 1

DECLARE @OrderDate datetime = GETDATE();
DECLARE @DueDate datetime = DATEADD(dd, 7, GETDATE());
DECLARE @CustomerID int = 1;
DECLARE @OrderID int;


INSERT INTO SalesLT.SalesOrderHeader (OrderDate, DueDate, CustomerID, ShipMethod)
VALUES
( @OrderDate, @DueDate, @CustomerID, 'CARGO TRANSPORT 5');

SET  @OrderID = IDENT_CURRENT('SalesLT.SalesOrderHeader');
PRINT  @OrderID 

GO
-- 2

SELECT * FROM SALESLT.SALESORDERDETAIL;
SELECT * FROM SALESLT.SalesOrderHeader;
DECLARE @OrderID int  = IDENT_CURRENT('SalesLT.SalesOrderHeader');;
DECLARE @ProductID int = 760;
DECLARE @Quantity int = 1;
DECLARE @UnitPrice float = 782.99;

IF EXISTS (
	SELECT H.SalesOrderID
	FROM SALESLT.SALESORDERHEADER AS H
	WHERE H.SALESORDERID = @OrderID
	)
	BEGIN
		INSERT INTO SALESLT.SALESORDERDETAIL (SALESORDERID, ORDERQTY, PRODUCTID, UNITPRICE)
		VALUES(@OrderID, @Quantity, @ProductID, @UnitPrice)
	END
ELSE
	BEGIN
		PRINT 'The order does not exist'
	END
GO


-- SECOND TEST
DECLARE @OrderID int  = 0;
DECLARE @ProductID int = 760;
DECLARE @Quantity int = 1;
DECLARE @UnitPrice float = 782.99;

IF EXISTS (
	SELECT H.SalesOrderID
	FROM SALESLT.SALESORDERHEADER AS H
	WHERE H.SALESORDERID = @OrderID
	)
	BEGIN
		INSERT INTO SALESLT.SALESORDERDETAIL (SALESORDERID, ORDERQTY, PRODUCTID, UNITPRICE)
		VALUES(@OrderID, @Quantity, @ProductID, @UnitPrice)
	END
ELSE
	BEGIN
		PRINT 'The order does not exist'
	END
GO
-- challenge 2
-- 1