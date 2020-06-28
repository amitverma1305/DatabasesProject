--Amit Verma
--SQL Basics Part-15
--Date: 06/25/2020

--Cursors

/*Relational Database Management Systems, including sql server are very good at handling data in SETS. For example, 
the following "UPDATE" query, updates a set of rows that matches the condition in the "WHERE" clause at the same time. */

Update tblProductSales Set UnitPrice = 50 where ProductId = 101

/*However, if there is ever a need to process the rows, on a row-by-row basis, then cursors are your choice. 
Cursors are very bad for performance, and should be avoided always. Most of the time, cursors can be very easily 
replaced using joins.

There are different types of cursors in sql server as listed below. We will talk about the differences between these 
cursor types in a later video session. 
1. Forward-Only
2. Static
3. Keyset
4. Dynamic 

*/

select top 10 *  from  tblProducts


Declare @ProductId int

-- Declare the cursor using the declare keyword
Declare ProductIdCursor CURSOR FOR 
Select ProductId from tblProductSales

-- Open statement, executes the SELECT statment
-- and populates the result set
Open ProductIdCursor

-- Fetch the row from the result set into the variable
Fetch Next from ProductIdCursor into @ProductId

-- If the result set still has rows, @@FETCH_STATUS will be ZERO
While(@@FETCH_STATUS = 0)
Begin
 Declare @ProductName nvarchar(50)
 Select @ProductName = Name from tblProducts where Id = @ProductId
 
 if(@ProductName = 'Product - 55')
 Begin
  Update tblProductSales set UnitPrice = 55 where ProductId = @ProductId
 End
 else if(@ProductName = 'Product - 65')
 Begin
  Update tblProductSales set UnitPrice = 65 where ProductId = @ProductId
 End
 else if(@ProductName like 'Product - 100%')
 Begin
  Update tblProductSales set UnitPrice = 1000 where ProductId = @ProductId
 End
 
 Fetch Next from ProductIdCursor into @ProductId 
End

-- Release the row set
CLOSE ProductIdCursor 
-- Deallocate, the resources associated with the cursor
DEALLOCATE ProductIdCursor


/* The cursor will loop thru each row in tblProductSales table. As there are 600,000 rows, to be processed on a row-by-row 
basis, it takes around 40 to 45 seconds on my machine. We can achieve this very easily using a join, and this will 
significantly increase the performance. */

Update tblProductSales
set UnitPrice = 
 Case 
  When Name = 'Product - 55' Then 155
  When Name = 'Product - 65' Then 165
  When Name like 'Product - 100%' Then 10001
 End     
from tblProductSales
join tblProducts
on tblProducts.Id = tblProductSales.ProductId
Where Name = 'Product - 55' or Name = 'Product - 65' or 
Name like 'Product - 100%'