-- lab 11 https://github.com/MicrosoftLearning/QueryingT-SQL/blob/master/Labs/Lab11.pdf
-- challenge 1
-- 1 E 2
SELECT * FROM SALESLT.SalesOrderDetail;
SELECT * FROM SALESLT.SalesOrderHeader;

DECLARE @SALESORDERID INT = 1;

BEGIN TRY
	IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader
				   WHERE SalesOrderID = @SalesOrderID)
	BEGIN
		-- Throw a custom error if the specified order doesn't exist
		DECLARE @error varchar(25);
		SET @error = 'Order #' + cast(@SalesOrderID as varchar) + ' does not exist';
		THROW 50001, @error, 0
	END
	ELSE
	BEGIN
	DELETE FROM SALESLT.SALESORDERDETAIL 
	WHERE SALESORDERID = @SALESORDERID;

	DELETE FROM SALESLT.SALESORDERHEADER
	WHERE SALESORDERID = @SALESORDERID;
	END
END TRY
BEGIN CATCH 
	PRINT ERROR_MESSAGE();
END CATCH;
GO

-- challenge 2

-- 1
SELECT * FROM SALESLT.SalesOrderDetail;
SELECT * FROM SALESLT.SalesOrderHeader;

DECLARE @SALESORDERID INT = 1;
-- uncomment the following line to specify an existing order
-- SELECT @SalesOrderID = MIN(SalesOrderID) FROM SalesLT.SalesOrderHeader; 
BEGIN TRY
	
	IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader
				   WHERE SalesOrderID = @SalesOrderID)
	BEGIN
		DECLARE @error varchar(25);
		SET @error = 'The Order with number #' + cast(@SalesOrderID as varchar) + ' does not exist in the database';
		THROW 50001, @error, 0
	END

	ELSE
	BEGIN
		BEGIN TRANSACTION
			DELETE FROM SALESLT.SALESORDERDETAIL 
			WHERE SALESORDERID = @SALESORDERID;

			--THROW 50001, 'Unexpected error', 0 --Uncomment to test transaction
			
			DELETE FROM SALESLT.SALESORDERHEADER
			WHERE SALESORDERID = @SALESORDERID;
		COMMIT TRANSACTION
	END

END TRY
BEGIN CATCH 
	IF @@TRANCOUNT > 0
	BEGIN
		ROLLBACK TRANSACTION;
		THROW;
	END
	PRINT ERROR_MESSAGE();
END CATCH;
GO
