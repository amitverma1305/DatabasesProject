/*
Why indexes?
Indexes are used by queries to find data from tables quickly. Indexes are created on tables and views. 
Index on a table or a view, is very similar to an index that we find in a book.
Table and View indexes, can help the query to find data quickly.
The existence of the right indexes, can drastically improve the performance of the query. 
If there is no index to help the query, then the query engine, checks every row in the table from the beginning to the end. 
This is called as Table Scan. Table scan is bad for performance.
*/

--Example
Select * from tblemployees where Salary > 50000 and Salary < 70000

--Creating index
CREATE Index IX_tblEmployee_Salary ON tblEmployees (SALARY ASC)

--How to check the index on a particualr table.
sp_helpindex tblemployees

--Dropping an Index
Drop index tblemployees.IX_tblEmployee_Salary

