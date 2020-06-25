--Amit Verma
--SQL Basics Part-13
--Date: 06/24/2020

--Subqueries in SQL
--Correalted Subqueries

drop table tblProduct
drop table tbl_ProductSales

Create Table tblProducts
(
 [Id] int identity primary key,
 [Name] nvarchar(50),
 [Description] nvarchar(250)
)

Create Table tblProductSales
(
 Id int primary key identity,
 ProductId int foreign key references tblProducts(Id),
 UnitPrice int,
 QuantitySold int
)

Insert into tblProducts values ('TV', '52 inch black color LCD TV')
Insert into tblProducts values ('Laptop', 'Very thin black color acer laptop')
Insert into tblProducts values ('Desktop', 'HP high performance desktop')

Insert into tblProductSales values(3, 450, 5)
Insert into tblProductSales values(2, 250, 7)
Insert into tblProductSales values(3, 450, 4)
Insert into tblProductSales values(3, 450, 9)

--01. Subquery
--Write a query to retrieve products that are not at all sold?
Select [Id], [Name], [Description]
from tblProducts
where Id not in (Select Distinct ProductId from tblProductSales)
-- Method-2 (Using Joins)
Select tblProducts.[Id], [Name], [Description]
from tblProducts
left join tblProductSales
on tblProducts.Id = tblProductSales.ProductId
where tblProductSales.ProductId IS NULL

--Sub query in the SELECT clause.
Select [Name],
(Select SUM(QuantitySold) from tblProductSales where ProductId = tblProducts.Id) as TotalQuantity
from tblProducts
order by Name

--Query with an equivalent join that produces the same result.
Select [Name], SUM(QuantitySold) as TotalQuantity
from tblProducts
left join tblProductSales
on tblProducts.Id = tblProductSales.ProductId
group by [Name]
order by Name

/*A subquery is simply a select statement, that returns a single value and can be nested inside a SELECT, UPDATE, INSERT, 
or DELETE statement. 
*/

--02. Correlated Subquery
/*The sub query results are then used by the outer query. A non-corelated subquery can be executed independently of the 
outer query.*/

Select [Id], [Name], [Description]
from tblProducts
where Id not in (Select Distinct ProductId from tblProductSales)

/*If the subquery depends on the outer query for its values, then that sub query is called as a correlated subquery. 
In the where clause of the subquery below, "ProductId" column get it's value from tblProducts table that is present in the 
outer query. So, here the subquery is dependent on the outer query for it's value, hence this subquery is a correlated 
subquery. Correlated subqueries get executed, once for every row that is selected by the outer query. Corelated subquery, 
cannot be executed independently of the outer query.*/

Select [Name],
(Select SUM(QuantitySold) from tblProductSales where ProductId = tblProducts.Id) as TotalQuantity
from tblProducts
order by Name