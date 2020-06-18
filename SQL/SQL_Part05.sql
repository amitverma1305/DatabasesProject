--Amit Verma
--SQL Basics

/*
Why indexes?
Indexes are used by queries to find data from tables quickly. Indexes are created on tables and views. 
Index on a table or a view, is very similar to an index that we find in a book.
Table and View indexes, can help the query to find data quickly.
The existence of the right indexes, can drastically improve the performance of the query. 
If there is no index to help the query, then the query engine, checks every row in the table from the beginning to the end. 
This is called as Table Scan. Table scan is bad for performance.
*/

--1. Example
Select * from tblemployees where Salary > 50000 and Salary < 70000

--Creating index
CREATE Index IX_tblEmployee_Salary ON tblEmployees (SALARY ASC)

--How to check the index on a particualr table.
sp_helpindex tblemployees

--Dropping an Index
Drop index tblemployees.IX_tblEmployee_Salary

--2. A clustered index determines the physical order of data in a table. For this reason, a table can have only one clustered index. 

CREATE TABLE [tblEmployee_CL]
(
 [Id] int Primary Key,
 [Name] nvarchar(50),
 [Salary] int,
 [Gender] nvarchar(10),
 [City] nvarchar(50),
 [FirstName] nvarchar(50),
 [LastName] nvarchar(50)
)

--Check if there is any index created automatically
execute sp_helpindex tblEmployee_CL
--Insert Data in non sequential order
Insert into tblEmployee_CL Values(3,'John',4500,'Male','New York','John','Cena')
Insert into tblEmployee_CL Values(1,'Sam',2500,'Male','London','Sam','Weber')
Insert into tblEmployee_CL Values(4,'Sara',5500,'Female','Tokyo','Sara','Kensky')
Insert into tblEmployee_CL Values(5,'Todd',3100,'Male','Toronto','Todd','Stenthil')
Insert into tblEmployee_CL Values(2,'Pam',6500,'Female','Sydney','Pam','Kaur')
--Check data (sorted automatically)
select * from tblEmployee_CL

--Cannot create more than one clustered index
Create Clustered Index IX_tblEmployee_Name ON tblEmployee_CL(Name)

--Drop Index
Drop index tblEmployee_CL.PK__tblEmplo__3214EC071EAFC541

--We can create composite index
Create Clustered Index IX_tblEmployee_Gender_Salary
ON tblEmployee_CL(Gender DESC, Salary ASC)

--3. Non Clustered Index
Create NonClustered Index IX_tblEmployee_Name
ON tblEmployee_CL(Name)

/*
Difference between Clustered and NonClustered Index:
1. Only one clustered index per table, where as you can have more than one non clustered index
2. Clustered index is faster than a non clustered index, because, the non-clustered index has to refer back 
to the table, if the selected column is not present in the index.
3. Clustered index determines the storage order of rows in the table, and hence doesn't require additional 
disk space, but where as a Non Clustered index is stored seperately from the table, additional storage space is required.
*/

--4. Unique Non Clustered Index
Create Unique NonClustered Index UIX_tblEmployee_FirstName_LastName
On tblEmployee_CL(FirstName, LastName)

--Difference b/w unique index and unique key constraint
--When we add a unique constraint, a unique index gets created behind the scenes.

ALTER TABLE tblEmployee_CL 
ADD CONSTRAINT UQ_tblEmployee_City 
UNIQUE NONCLUSTERED (City)

/*
1. By default, a PRIMARY KEY constraint, creates a unique clustered index, where as a UNIQUE constraint creates a 
unique nonclustered index. These defaults can be changed if you wish to.

2. A UNIQUE constraint or a UNIQUE index cannot be created on an existing table, if the table contains duplicate values 
in the key columns. Obviously, to solve this,remove the key columns from the index definition or delete or update the 
duplicate values.
*/

--Advantages of indexes

--Create a Non-Clustered Index on Salary Column
Create NonClustered Index IX_tblEmployee_Salary
On tblEmployee_CL(Salary Asc)

--Select, Update, Delete, Order By are all arranged so it can be scanned easily.
Select * from tblEmployee_CL where Salary > 4000 and Salary < 8000

/*

Diadvantages of Indexes:
Additional Disk Space: Clustered Index does not, require any additional storage. Every Non-Clustered index requires additional 
space as it is stored separately from the table.The amount of space required will depend on the size of the table, and the number 
and types of columns used in the index.

Insert Update and Delete statements can become slow: When DML (Data Manipulation Language) statements (INSERT, UPDATE, DELETE) 
modifies data in a table, the data in all the indexes also needs to be updated. Indexes can help, to search and locate the rows, 
that we want to delete, but too many indexes to update can actually hurt the performance of data modifications.
*/