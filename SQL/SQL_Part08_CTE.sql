--Amit Verma
--SQL Basics Part-08
--Date: 06/20/2020

--Common Table Expression
--Querying data using table variable
--Querying data using Derived Table
--CTE
--Multiple CTE in single query	
--Updatable CTE
--Resursive CTE

/*Why CTE?
	a. Views get saved in the database, and can be available to other queries and stored procedures. However, if this view 
is only used at this one place, it can be easily eliminated using other options, like CTE, Derived Tables, Temp Tables, 
Table Variable etc.
	b.  Temporary tables are stored in TempDB. Local temporary tables are visible only in the current session, and can be 
	shared between nested stored procedure calls. Global temporary tables are visible to other sessions and are destroyed, 
	when the last connection referencing the table is closed.
	c. A table variable is also created in TempDB. The scope of a table variable is the batch, stored procedure, 
	or statement block in which it is declared. They can be passed as parameters between procedures.
	d. Derived tables are available only in the context of the current query.

*/
--01. Using Table Variable
Declare @tblEmployeeCount table
(DeptName nvarchar(20),DepartmentId int, TotalEmployees int)

Insert @tblEmployeeCount
Select departmentName, DepartmentId, COUNT(*) as TotalEmployees
  from tblemployees
  join tblDepartment
  on tblEmployees.DepartmentId = tblDepartment.Id
  group by DepartmentName, DepartmentId

Select DeptName, TotalEmployees
From @tblEmployeeCount
where  TotalEmployees >= 2

--02. Using Derived Table
Select departmentName, TotalEmployees
from 
 (
  Select departmentName, DepartmentId, COUNT(*) as TotalEmployees
  from tblemployees
  join tblDepartment
  on tblEmployees.DepartmentId = tblDepartment.Id
  group by DepartmentName, DepartmentId
 ) 
as EmployeeCount
where TotalEmployees >= 2

--02. CTE
with EmployeeCount(departmentName,DepartmentId,TotalEmployees)
as
(
  Select departmentName, DepartmentId, COUNT(*) as TotalEmployees
  from tblemployees
  join tblDepartment
  on tblEmployees.DepartmentId = tblDepartment.Id
  group by DepartmentName, DepartmentId
)

select departmentName,TotalEmployees from EmployeeCount
where TotalEmployees>=2

/*A CTE is a temporary result set, that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement, 
that immediately follows the CTE.*/

--03. Mulitple CTE in single query
With EmployeesCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
 Select DepartmentName, COUNT(tblemployees.ID) as TotalEmployees
	from tblemployees join tblDepartment 
		on tblemployees.DepartmentId = tblDepartment.Id
			where DepartmentName IN ('Payroll','IT')
				group by DepartmentName
),

EmployeesCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
 Select DepartmentName, COUNT(tblemployees.ID) as TotalEmployees
	from tblemployees join tblDepartment 
		on tblemployees.DepartmentId = tblDepartment.Id
			where DepartmentName IN ('HR','Finance')
				group by DepartmentName 
)

Select * from EmployeesCountBy_HR_Admin_Dept 
UNION
Select * from EmployeesCountBy_Payroll_IT_Dept

--04. Updatable CTE 1 base Table
With Employees_Name_Gender
as
(
 Select Id, firstname, Gender from tblemployees
)

Update Employees_Name_Gender Set Gender = 'Female' where Id = 19

select * from tblemployees

--05. Updatable CTE 2 base Table
With Employees_Name_Gender
as
(
 Select emp.ID, firstname, Gender from tblemployees emp join tblDepartment dept
	on emp.DepartmentId=dept.Id
)

Update Employees_Name_Gender Set Gender = 'male' where Id = 19

select * from tblemployees

--06. CTE on 2 base Table, update affecting more than one base table
With Employees_Name_Gender
as
(
 Select emp.ID, firstname, Gender,DepartmentName from tblemployees emp join tblDepartment dept
	on emp.DepartmentId=dept.Id
)

Update Employees_Name_Gender Set Gender = 'male',DepartmentName='IT' where Id = 19
/*Msg 4405, Level 16, State 1, Line 118
View or function 'Employees_Name_Gender' is not updatable because the modification affects multiple base tables.*/

--7. CTE on 2 base Table, update affecting one base table incorrectly
With Employees_Name_Gender
as
(
 Select emp.ID, firstname, Gender,DepartmentName from tblemployees emp join tblDepartment dept
	on emp.DepartmentId=dept.Id
)

Update Employees_Name_Gender Set DepartmentName='IT' where Id = 19

/*
1. A CTE is based on a single base table, then the UPDATE suceeds and works as expected.
2. A CTE is based on more than one base table, and if the UPDATE affects multiple base tables, the update is not allowed 
and the statement terminates with an error.
3. A CTE is based on more than one base table, and if the UPDATE affects only one base table, the UPDATE 
succeeds(but not as expected always)*/

--08. Resurcive CTE
Select Employee.firstname as [Employee Name],
IsNull(Manager.firstname, 'Super Boss') as [Manager Name]
from tblemployees Employee
left join tblemployees Manager
on Employee.ManagerId = Manager.ID


With
  EmployeesCTE (EmployeeId, Name, ManagerId, [Level])
  as
  (
    Select ID, firstname, ManagerId, 1
    from tblemployees
    where ManagerId is null
    
    union all
    
    Select tblemployees.ID, tblemployees.firstname, 
    tblemployees.ManagerId, EmployeesCTE.[Level] + 1
    from tblemployees
    join EmployeesCTE
    on tblemployees.ManagerID = EmployeesCTE.EmployeeId
  )
Select EmpCTE.Name as Employee, Isnull(MgrCTE.Name, 'Super Boss') as Manager, 
EmpCTE.[Level] 
from EmployeesCTE EmpCTE
left join EmployeesCTE MgrCTE
on EmpCTE.ManagerId = MgrCTE.EmployeeId

