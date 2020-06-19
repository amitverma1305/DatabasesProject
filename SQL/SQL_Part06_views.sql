--Amit Verma
--SQL Basics Part06

--What is a view?
--Advantages of view.
--Updatable View
--Indexed View
--Limitation of Views

-- A View is a saved SQL query. A view can be considered as a virtual table.
select emp.ID, firstname, salary, gender, DepartmentName
	from tblemployees emp inner join tblDepartment dept 
		on emp.DepartmentId=dept.Id

--01.	Creating a view	
Create view vwEmployeesByDepartment
as
select emp.ID, firstname, salary, gender, DepartmentName
	from tblemployees emp inner join tblDepartment dept 
		on emp.DepartmentId=dept.Id

--2.	Advantages of using views:
/*
1. Views can be used to reduce the complexity of the database schema.
2. Views can be used as a mechanism to implement row and column level security.
*/

--3.	 

Create view vWEmployeesDataExceptSalary
as
Select Id, firstname, Gender, DepartmentId
from tblemployees

select * from vWEmployeesDataExceptSalary

--4. Updating View
Update vWEmployeesDataExceptSalary 
Set firstname = 'Sparshi' Where Id = 2

--Deleteing/Inserting data in view
Delete from vWEmployeesDataExceptSalary where Id = 2
Insert into vWEmployeesDataExceptSalary values (2, 'Sparsh', 'Male', 2)

/*If a view is based on multiple tables, and if you update the view, it may not update the underlying base 
tables correctly. To correctly update a view, that is based on multiple table, INSTEAD OF triggers are used.*/

/*
A standard or Non-indexed view, is just a stored SQL query. When, we try to retrieve data from the view, the data 
is actually retrieved from the underlying base tables. So, a view is just a virtual table it does not store any data, 
by default.

However, when you create an index, on a view, the view gets materialized. This means, the view is now, capable of 
storing data. In SQL server, we call them Indexed views and in Oracle, Materialized views.
*/

--5. Indexed View
--Script to create table tblProduct
Create Table tblProduct
(
 ProductId int primary key,
 Name nvarchar(20),
 UnitPrice int
)

--Script to pouplate tblProduct, with sample data
Insert into tblProduct Values(1, 'Books', 20)
Insert into tblProduct Values(2, 'Pens', 14)
Insert into tblProduct Values(3, 'Pencils', 11)
Insert into tblProduct Values(4, 'Clips', 10)

--Script to create table tblProductSales
Create Table tblProductSales
(
 ProductId int,
 QuantitySold int
)

--Script to pouplate tblProductSales, with sample data
Insert into tblProductSales values(1, 10)
Insert into tblProductSales values(3, 23)
Insert into tblProductSales values(4, 21)
Insert into tblProductSales values(2, 12)
Insert into tblProductSales values(1, 13)
Insert into tblProductSales values(3, 12)
Insert into tblProductSales values(4, 13)
Insert into tblProductSales values(1, 11)
Insert into tblProductSales values(2, 12)
Insert into tblProductSales values(1, 14)

create view vWTotalSalesByProduct
with SchemaBinding
as
select Name, sum(isnull(prd.UnitPrice*prdSale.QuantitySold,0)) as TotalSales, count_big(*) as QuantitySold
	from dbo.tblProduct prd inner join dbo.tblProductSales prdSale
		on prd.ProductId = prdSale.ProductId
			group by Name


select * from vWTotalSalesByProduct

Create Unique Clustered Index UIX_vWTotalSalesByProduct_Name
on vWTotalSalesByProduct(Name)

/*
If you want to create an Index, on a view, the following rules should be followed by the view. 
For the complete list of all rules, please check MSDN.

1. The view should be created with SchemaBinding option

2. If an Aggregate function in the SELECT LIST, references an expression, and if there is a possibility for 
that expression to become NULL, then, a replacement value should be specified. In this example, we are using, 
ISNULL() function, to replace NULL values with ZERO.

3. If GROUP BY is specified, the view select list must contain a COUNT_BIG(*) expression

4. The base tables in the view, should be referenced with 2 part name. */

--6. Limitations of Views:
	--a. You cannot pass parameters to a view. Table Valued functions are an excellent replacement for parameterized views.
	--b. Rules and Defaults cannot be associated with views.
	--c. The ORDER BY clause is invalid in views unless TOP or FOR XML is also specified.
	--d. Views cannot be based on temporary tables.