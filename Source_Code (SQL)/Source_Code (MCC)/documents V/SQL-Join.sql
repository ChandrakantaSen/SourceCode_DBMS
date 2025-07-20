--Inner Join 
SELECT  t1.OrderID,  t0.ProductID,  t0.Name,  t0.UnitPrice,  t1.Quantity,  t1.Price
FROM  tblProduct AS  t0
INNER JOIN  tblOrder AS  t1 ON  t0.ProductID =  t1.ProductID
ORDER BY  t1.OrderID

--Inner Join among more than two tables

SELECT  t1.OrderID,  t0.ProductID,  t0.Name,  t0.UnitPrice,  t1.Quantity,  t1.Price,  t2.Name AS  Customer
FROM  tblProduct AS  t0
INNER JOIN  tblOrder AS  t1 ON  t0.ProductID =  t1.ProductID
INNER JOIN  tblCustomer AS  t2 ON  t1.CustomerID = ( t2.CustID)
ORDER BY  t1.OrderID

--Inner join on multiple conditions

SELECT  t1.OrderID,  t0.ProductID,  t0.Name,  t0.UnitPrice,  t1.Quantity,  t1.Price,  t2.Name AS  Customer
FROM  tblProduct AS  t0
INNER JOIN  tblOrder AS  t1 ON  t0.ProductID =  t1.ProductID
INNER JOIN  tblCustomer AS  t2 ON t1.CustomerID = t2.CustID AND t1.ContactNo =  t2.ContactNo
ORDER BY  t1.OrderID

--Left Outer Join

SELECT  t1.OrderID  AS  OrderID ,  t0.ProductID ,  t0.Name ,  t0.UnitPrice ,  t1.Quantity  AS  Quantity ,  t1.Price  AS  Price 
FROM  tblProduct  AS  t0 
LEFT OUTER JOIN  tblOrder  AS  t1  ON  t0.ProductID  =  t1.ProductID 
ORDER BY  t0.ProductID 

--Right Outer Join

SELECT  t1.OrderID  AS  OrderID ,  t0.ProductID ,  t0.Name ,  t0.UnitPrice ,  t1.Quantity  AS  Quantity ,  t1.Price  AS  Price 
FROM  tblProduct  AS  t0 
RIGHT OUTER JOIN  tblOrder  AS  t1  ON  t0.ProductID  =  t1.ProductID 
ORDER BY  t0.ProductID 

--Full Outer Join

SELECT  t1.OrderID  AS  OrderID ,  t0.ProductID ,  t0.Name ,  t0.UnitPrice ,  t1.Quantity  AS  Quantity ,  t1.Price  AS  Price 
FROM  tblProduct  AS  t0 
FULL OUTER JOIN  tblOrder  AS  t1  ON  t0.ProductID  =  t1.ProductID 
ORDER BY  t0.ProductID 

--Cross Join

SELECT  t1.OrderID,  t0.ProductID,  t0.Name,  t0.UnitPrice,  t1.Quantity,  t1.Price
FROM  tblProduct AS  t0,  tblOrder AS  t1
ORDER BY  t0.ProductID

--Select data

SELECT * FROM tblCustomer
SELECT * FROM tblProduct
SELECT * FROM tblOrder