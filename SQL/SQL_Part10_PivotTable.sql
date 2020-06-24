--Amit Verma
--SQL Basics Part-10
--Date: 06/22/2020

--Pivot Tables 

/*
Pivot is a sql server operator that can be used to turn unique values from one column, into multiple columns in the output, 
there by effectively rotating a table.*/
Create Table tbl_ProductSales
(
 SalesAgent nvarchar(50),
 SalesCountry nvarchar(50),
 SalesAmount int
)

Insert into tbl_ProductSales values('Tom', 'UK', 200)
Insert into tbl_ProductSales values('John', 'US', 180)
Insert into tbl_ProductSales values('John', 'UK', 260)
Insert into tbl_ProductSales values('David', 'India', 450)
Insert into tbl_ProductSales values('Tom', 'India', 350)
Insert into tbl_ProductSales values('David', 'US', 200)
Insert into tbl_ProductSales values('Tom', 'US', 130)
Insert into tbl_ProductSales values('John', 'India', 540)
Insert into tbl_ProductSales values('John', 'UK', 120)
Insert into tbl_ProductSales values('David', 'UK', 220)
Insert into tbl_ProductSales values('John', 'UK', 420)
Insert into tbl_ProductSales values('David', 'US', 320)
Insert into tbl_ProductSales values('Tom', 'US', 340)
Insert into tbl_ProductSales values('Tom', 'UK', 660)
Insert into tbl_ProductSales values('John', 'India', 430)
Insert into tbl_ProductSales values('David', 'India', 230)
Insert into tbl_ProductSales values('David', 'India', 280)
Insert into tbl_ProductSales values('Tom', 'UK', 480)
Insert into tbl_ProductSales values('John', 'US', 360)
Insert into tbl_ProductSales values('David', 'UK', 140)

select * from tbl_ProductSales

--Group By clause
select SalesCountry,SalesAgent, sum(SalesAmount) as [Total] from tbl_ProductSales
	group by SalesCountry,SalesAgent
		order by SalesCountry,SalesAgent

--Query using Pivot
Select SalesAgent, India, US, UK
	from tbl_ProductSales
	pivot
	(
	sum(salesamount) for salescountry
	In (India,US,UK)
	)
as PivotTable


--Pivot with additional columns
Create Table tbl_ProductsSale01
(
   Id int primary key,
   SalesAgent nvarchar(50),
   SalesCountry nvarchar(50),
   SalesAmount int
)

Insert into tbl_ProductsSale01 values(1, 'Tom', 'UK', 200)
Insert into tbl_ProductsSale01 values(2, 'John', 'US', 180)
Insert into tbl_ProductsSale01 values(3, 'John', 'UK', 260)
Insert into tbl_ProductsSale01 values(4, 'David', 'India', 450)
Insert into tbl_ProductsSale01 values(5, 'Tom', 'India', 350)
Insert into tbl_ProductsSale01 values(6, 'David', 'US', 200)
Insert into tbl_ProductsSale01 values(7, 'Tom', 'US', 130)
Insert into tbl_ProductsSale01 values(8, 'John', 'India', 540)
Insert into tbl_ProductsSale01 values(9, 'John', 'UK', 120)
Insert into tbl_ProductsSale01 values(10, 'David', 'UK', 220)
Insert into tbl_ProductsSale01 values(11, 'John', 'UK', 420)
Insert into tbl_ProductsSale01 values(12, 'David', 'US', 320)
Insert into tbl_ProductsSale01 values(13, 'Tom', 'US', 340)
Insert into tbl_ProductsSale01 values(14, 'Tom', 'UK', 660)
Insert into tbl_ProductsSale01 values(15, 'John', 'India', 430)
Insert into tbl_ProductsSale01 values(16, 'David', 'India', 230)
Insert into tbl_ProductsSale01 values(17, 'David', 'India', 280)
Insert into tbl_ProductsSale01 values(18, 'Tom', 'UK', 480)
Insert into tbl_ProductsSale01 values(19, 'John', 'US', 360)
Insert into tbl_ProductsSale01 values(20, 'David', 'UK', 140)

Select SalesAgent, India, US, UK
from tbl_ProductsSale01
Pivot
(
   Sum(SalesAmount) for SalesCountry in ([India],[US],[UK])
)
as PivotTable


Select SalesAgent, India, US, UK
from
(
   Select SalesAgent, SalesCountry, SalesAmount from tbl_ProductsSale01
) as SourceTable
Pivot
(
 Sum(SalesAmount) for SalesCountry in (India, US, UK)
) as PivotTable