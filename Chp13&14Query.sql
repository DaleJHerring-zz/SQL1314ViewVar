--Chp 13
--1
CREATE VIEW CustomerAddresses
AS
SELECT Customers.CustomerID, EmailAddress, FirstName, LastName, Line1 AS BillLine1, Line2 AS BillLine2, 
       City AS BillCity, State AS BillState, ZipCode AS BillZip, Line1 AS ShipLine1, Line2 AS ShipLine2,
	   City AS ShipCity, State AS ShipState, ZipCode AS ShipZip
FROM Customers JOIN Addresses
     ON Customers.CustomerID = Addresses.CustomerID;

GO;

--2
SELECT CustomerID, LastName, FirstName, BillLine1
FROM CustomerAddresses;

--3
UPDATE CustomerAddresses
SET ShipLine1 = '1990 Westwood Blvd.'
WHERE CustomerID = 8;

GO;

--4
CREATE VIEW OrderItemProducts
AS
SELECT Orders.OrderID, OrderDate, TaxAmount, ShipDate, ItemPrice, DiscountAmount, 
       (ItemPrice - DiscountAmount) AS FinalPrice, Quantity, 
	   ((ItemPrice - DiscountAmount) * Quantity) AS ItemTotal, ProductName
FROM Orders JOIN OrderItems
     ON Orders.OrderID = OrderItems.OrderID
	 JOIN Products
	 ON OrderItems.ProductID = Products.ProductID;

GO;

--5
CREATE VIEW ProductSummary
AS
SELECT ProductName, Count(Quantity) AS OrderCount, Sum(ItemTotal) AS OrderTotal
FROM OrderItemProducts
GROUP BY ProductName;

GO;

--6
SELECT TOP 5 ProductName, OrderCount, OrderTotal
FROM ProductSummary
ORDER BY OrderTotal DESC, OrderCount DESC;

--Chp 14
--1
DECLARE @ProductCount int;
SELECT @ProductCount = COUNT(ProductID)
FROM Products;
  IF(@ProductCount >= 7)
    PRINT 'The number of products is greater than or equal to 7.';
  ELSE
    PRINT 'The number of products is less than 7.';
	
GO;

--2
DECLARE @ProductCount int, @AVGListPrice money;
SELECT @ProductCount = COUNT(ProductID), @AVGListPrice = AVG(ListPrice)
FROM #ProductCopy
  IF(@ProductCount >= 7)
    PRINT 'Product count is ' + CAST(@ProductCount AS varchar) + ' and average list price is ' + 
	CAST(@AVGListprice AS varchar);
  ELSE
    PRINT 'The number of products is less than 7.';

GO;

--3
DECLARE @Ceiling int, @Counter int;
SET @Ceiling = 100
SET @Counter = 0
PRINT 'Common factors of 10 and 20'
WHILE(@Counter < @Ceiling)
BEGIN
  SET @Counter = @Counter + 1
  IF(10 % @Counter = 0 AND 20 % @Counter = 0)
    PRINT @Counter
END;

GO;

--4
BEGIN TRY
  INSERT Categories
  VALUES('Guitars');
  PRINT 'SUCCESS: Record was inserted.';
END TRY
BEGIN CATCH
  PRINT 'FAILURE: Record was not inserted.';
  PRINT 'Error ' + CAST(ERROR_NUMBER() AS varchar) + ': ' + ERROR_MESSAGE();
END CATCH;




	



