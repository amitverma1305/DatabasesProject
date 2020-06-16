--Amit Verma
--SQL Basics

--Temporary Table


--1. Temporary Table
/*Temporary tables, are very similar to the permanent tables. Permanent tables get created in the database you specify, and 
remain in the database permanently, until you delete (drop) them. On the other hand, temporary tables get created in the TempDB 
and are automatically deleted, when they are no longer used.*/

--Local Temporary Table

Create Table #PersonDetails(Id int, Name nvarchar(20))
Insert into #PersonDetails Values(1, 'Amit')
Insert into #PersonDetails Values(2, 'Akshay')
Insert into #PersonDetails Values(3, 'Gagan')

select* from #PersonDetails

--Check name of the table:
select name from tempdb..sysobjects where name like '#PersonDetails%'


/*Difference Between Local and Global Temporary Tables:
1. Local Temp tables are prefixed with single pound (#) symbol, where as gloabl temp tables are prefixed 
with 2 pound (##) symbols.

2. SQL Server appends some random numbers at the end of the local temp table name, where this is not done 
for global temp table names.

3. Local temporary tables are only visible to that session of the SQL Server which has created it, where 
as Global temporary tables are visible to all the SQL server sessions

4. Local temporary tables are automatically dropped, when the session that created the temporary tables is 
closed, where as Global temporary tables are destroyed when the last connection that is referencing the global 
temp table is closed.*/

--Creating Global temporary Table
Create Table ##EmployeeDetails(Id int, Name nvarchar(20))
