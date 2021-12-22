-- Create a SELECT statement
SELECT OrderID, CustomerID, OrderDate
FROM Sales.Orders
WHERE CustomerID = 578
ORDER BY OrderDate DESC

-- Use functions to calculate values
SELECT OrderLineID
	Quantity,
	UnitPrice,
	TaxRate,
	Quantity*UnitPrice AS ExtendedPrice
	Quantity*UnitPrice*(TaxRate) AS TaxDue
	Format((Quantity*UnitPrice)+(Quantity*UnitPrice*(TaxRate/100)), 'C') AS TotalPrice
FROM Sales.OrderLines

-- Write an UPDATE statement 
UPDATE Sales.SpecialDeals
	SET EndDate = '12/31/2019', DealDescription = '10% 2019 USB Wingtip'
	WHERE SpecialDealID = 1

-- Add data with an INSERT statement 
INSERT INTO dbo.Guests (Firstname, LastName)
VALUES ('Jeremy', 'Kant'), ('Rachel', 'Morris')

SELECT * FROM dbo.Guests

-- Create a view of the data 
SELECT dbo.Guests.GuestID,
	dbo.Guests.FirstName,
	dbo.Guests.LastName,
	dbo.Guests.Birthdate,
	dbo.Reservations.RoomName,
	dbo.Reservations.ReservationID
FROM dbo.Guests
INNER JOIN dbo.Reservations ON dbo.Guests.GuestID = dbo.Reservations.GuestID