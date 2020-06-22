--Amit Verma
--SQL Basics Part-09
--Date: 06/20/2020

--Database Normalization

/*Database normalization is the process of organizing data to minimize data redundancy (data duplication), 
which in turn ensures data consistency.*/

--01. 1st Normal Form
/*A table is said to be in 1NF if:
	a.	The data in each column should be atomic. No multiple values, sepearated by comma.
	b.	The table does not contain any repeating column groups
	c.	Identify each record uniquely using primary key.

*/
--02. 2nd Normal Form
/*
A table is said to be in 2NF if:
	a.	The table meets all the conditions of 1NF
	b.	Move redundant data to a separate table
	c.	Create relationship between these tables using foreign keys.*/

--03. 3rd Normal Form

/*A table is said to be in 3NF if:
	a.	Meets all the conditions of 1NF and 2NF
	b.	Does not contain columns (attributes) that are not fully dependent upon the primary key
*/