

create function SalesLt.gettorders (@custid as int , @n as int) returns table
as
return
	select top (@n) salesorderid, orderdate
	from saleslt.SalesOrderHeader as s
	where customerId = @custid
	order by salesorderid desc, orderdate desc;

GO
select * from SalesLT.Customer;
select * from saleslt.SalesOrderHeader;



---------------------------------------------------------

select c.CustomerID, c.companyname, o.salesorderid, o.orderdate
from saleslt.Customer as c
-- cross apply SalesLT.gettorders(c.CustomerID, 3) as o; 
OUTER apply SalesLT.gettorders(c.CustomerID, 3) as o; 

--------------------------------------------------------
delete from saleslt.SalesOrderdetail
where salesorderid = 71950;

SELECT * FROM SALESLT.SALESORDERDETAIL;
SELECT * FROM SALESLT.SalesOrderHeader;

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

-------------

select max(CustomerID) as maxcust
from SalesLT.Customer;

--Create integer partition function for 15,000 partitions.  
