--Amit Verma
--SQL Basics Part-12
--Date: 06/23/2020

--Transactions in SQL

/*A transaction is a group of commands that change the data stored in a database. A transaction, is treated as a single unit. 
A transaction ensures that, either all of the commands succeed, or none of them. If one of the commands in the transaction 
fails, all of the commands fail, and any data that was modified in the database is rolled back. In this way, transactions 
maintain the integrity of data in a database.

Transaction processing follows these steps:
1. Begin a transaction.
2. Process database commands.
3. Check for errors. 
   If errors occurred, 
       rollback the transaction, 
   else, 
       commit the transaction

*/

select * from tblProduct

begin transaction
	update tblProduct set QtyAvailable=200 where ProductId=1
rollback transaction


Create Table tblMailingAddress
(
   AddressId int NOT NULL primary key,
   EmployeeNumber int,
   HouseNumber nvarchar(50),
   StreetAddress nvarchar(50),
   City nvarchar(10),
   PostalCode nvarchar(50)
)

Insert into tblMailingAddress values (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')


Create Table tblPhysicalAddress
(
 AddressId int NOT NULL primary key,
 EmployeeNumber int,
 HouseNumber nvarchar(50),
 StreetAddress nvarchar(50),
 City nvarchar(10),
 PostalCode nvarchar(50)
)

Insert into tblPhysicalAddress values (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')

Create Procedure spUpdateAddress
as
Begin
 Begin Try
  Begin Transaction
   Update tblMailingAddress set City = 'LONDON' 
   where AddressId = 1 and EmployeeNumber = 101
   
   Update tblPhysicalAddress set City = 'LONDON' 
   where AddressId = 1 and EmployeeNumber = 101
  Commit Transaction
 End Try
 Begin Catch
  Rollback Transaction
 End Catch
End

exec spUpdateAddress

select * from tblMailingAddress
select * from tblPhysicalAddress

/*Transcation will roll back as we are now trying to insert City name greater than the column length i.e. 10.
And the one affected commnd will also be rolled back as the transcation is commited if all the statements are 
executed without any error	*/
Alter Procedure spUpdateAddress
as
Begin
 Begin Try
  Begin Transaction
   Update tblMailingAddress set City = 'LONDON12' 
   where AddressId = 1 and EmployeeNumber = 101
   
   Update tblPhysicalAddress set City = 'LONDON LONDON' 
   where AddressId = 1 and EmployeeNumber = 101
  Commit Transaction
 End Try
 Begin Catch
  Rollback Transaction
 End Catch
End


exec spUpdateAddress

/*
A transaction is a group of database commands that are treated as a single unit. A successful transaction 
must pass the "ACID" test, that is, it must be
A - Atomic
C - Consistent
I - Isolated
D - Durable

Atomic - All statements in the transaction either completed successfully or they were all rolled back. The task that 
the set of operations represents is either accomplished or not, but in any case not left half-done. For example, in 
the spUpdateInventory_and_Sell stored procedure, both the UPDATE statements, should succeed. If one UPDATE statement 
succeeds and the other UPDATE statement fails, the database should undo the change made by the first UPDATE statement, 
by rolling it back. In short, the transaction should be ATOMIC.


Consistent - All data touched by the transaction is left in a logically consistent state. For example, if stock available 
numbers are decremented from tblProductTable, then, there has to be a related entry in tblProductSales table. The inventory 
can't just disappear.

Isolated - The transaction must affect data without interfering with other concurrent transactions, or being interfered with 
by them. This prevents transactions from making changes to data based on uncommitted information, for example changes to a 
record that are subsequently rolled back. Most databases use locking to maintain transaction isolation.

Durable - Once a change is made, it is permanent. If a system error or power failure occurs before a set of commands is 
complete, those commands are undone and the data is restored to its original state once the system begins running again.
*/


Create Procedure spUpdateInventory_and_Sell
as
Begin
  Begin Try
    Begin Transaction
      Update tblProduct set QtyAvailable = (QtyAvailable - 10)
      where ProductId = 1

      Insert into tblProductSales values(3, 1, 10)
    Commit Transaction
  End Try
  Begin Catch 
    Rollback Transaction
  End Catch 
End