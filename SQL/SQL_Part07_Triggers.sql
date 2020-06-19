--Amit Verma
--SQL Basics Part06

--What is trigger
--Insert Trigger
--Delete Trigger
--Update Trigger
--Instead of Insert
--Instead of Update

--1. Triggers
/*A trigger is a special kind of stored procedure that automatically executes when an event occurs in the database server.
DML stands for Data Manipulation Language. INSERT, UPDATE, and DELETE statements are DML statements. 
DML triggers are fired, when ever data is modified using INSERT, UPDATE, and DELETE events.

DML triggers can be again classified into 2 types.
1. After triggers (Sometimes called as FOR triggers)
2. Instead of triggers

After triggers, as the name says, fires after the triggering action. The INSERT, UPDATE, and DELETE statements, 
causes an after trigger to fire after the respective statements complete execution.

On ther hand, as the name says, INSTEAD of triggers, fires instead of the triggering action. The INSERT, UPDATE, 
and DELETE statements, can cause an INSTEAD OF trigger to fire INSTEAD OF the respective statement execution.
*/

--SQL Script to create tblEmployeeAudit table:
CREATE TABLE tblEmployeeAudit
(
  Id int identity(1,1) primary key,
  AuditData nvarchar(1000)
)

--2. Insert Trigger
create TRIGGER tr_tblEMployee_ForInsert
ON tblEmployees
FOR INSERT
AS
BEGIN
 Declare @Id int
 Select @Id = ID from inserted
 
 insert into tblEmployeeAudit 
 values('New employee with Id  = ' + Cast(@Id as nvarchar(5)) + ' is added at ' + cast(Getdate() as nvarchar(20)))
END

select * from tblemployees

Insert into tblemployees values (20,'Tan','Giltman','1987/01/14', 24300, 'London','male', 1,18,'Harold','Tan@pp.com')

select * from tblEmployeeAudit

--3. Delete Trigger
create TRIGGER tr_tblEMployee_ForDelete
ON tblEmployees
FOR Delete
AS
BEGIN
 Declare @Id int
 Select @Id = ID from deleted
 
 insert into tblEmployeeAudit 
 values('An exisiting Employee with Id  = ' + Cast(@Id as nvarchar(5)) + ' is deleted at ' + cast(Getdate() as nvarchar(20)))
END

delete from tblemployees where id=20

select * from tblEmployeeAudit

/*Triggers make use of 2 special tables, INSERTED and DELETED. The inserted table contains the updated data and the 
deleted table contains the old data. The After trigger for UPDATE event, makes use of both inserted and deleted tables. */

--4. Update Trigger
--Create AFTER UPDATE trigger script:
Create trigger tr_tblEmployee_ForUpdate
on tblEmployees
for Update
as
Begin
 Select * from deleted
 Select * from inserted 
End


--Execute the query
Update tblemployees set firstname = 'Adrin',middlename='J',lastname='mesina' ,Salary = 211000, 
Gender = 'male',dob='06/30/1995' where Id = 19

select * from tblemployees


Alter trigger tr_tblEmployee_ForUpdate
on tblEmployees
for Update
as
Begin
      -- Declare variables to hold old and updated data
      Declare @Id int
      Declare @OldName nvarchar(20), @NewName nvarchar(20)
      Declare @OldSalary int, @NewSalary int
      Declare @OldGender nvarchar(20), @NewGender nvarchar(20)
      Declare @OldDeptId int, @NewDeptId int
     
      -- Variable to build the audit string
      Declare @AuditString nvarchar(1000)
      
      -- Load the updated records into temporary table
      Select *
      into #TempTable
      from inserted
     
      -- Loop thru the records in temp table
      While(Exists(Select Id from #TempTable))
      Begin
            --Initialize the audit string to empty string
            Set @AuditString = ''
           
            -- Select first row data from temp table
            Select Top 1 @Id = Id, @NewName = firstname, 
            @NewGender = Gender, @NewSalary = Salary,
            @NewDeptId = DepartmentId
            from #TempTable
           
            -- Select the corresponding row from deleted table
            Select @OldName = firstname, @OldGender = Gender, 
            @OldSalary = Salary, @OldDeptId = DepartmentId
            from deleted where Id = @Id
   
     -- Build the audit string dynamically           
            Set @AuditString = 'Employee with Id = ' + Cast(@Id as nvarchar(4)) + ' changed'
            if(@OldName <> @NewName)
                  Set @AuditString = @AuditString + ' NAME from ' + @OldName + ' to ' + @NewName
                 
            if(@OldGender <> @NewGender)
                  Set @AuditString = @AuditString + ' GENDER from ' + @OldGender + ' to ' + @NewGender
                 
            if(@OldSalary <> @NewSalary)
                  Set @AuditString = @AuditString + ' SALARY from ' + Cast(@OldSalary as nvarchar(10))+ ' to ' + Cast(@NewSalary as nvarchar(10))
                  
     if(@OldDeptId <> @NewDeptId)
                  Set @AuditString = @AuditString + ' DepartmentId from ' + Cast(@OldDeptId as nvarchar(10))+ ' to ' + Cast(@NewDeptId as nvarchar(10))
           
            insert into tblEmployeeAudit values(@AuditString)
            
            -- Delete the row from temp table, so we can move to the next row
            Delete from #TempTable where Id = @Id
      End
End

--5. Instead of Insert Trigger
Create view vWEmployeeDetails
as
Select tblemployees.ID, firstname, Gender, DepartmentName
from tblemployees
join tblDepartment
on tblemployees.DepartmentId = tblDepartment.Id

select * from vWEmployeeDetails

--Inserting a row in vWEmployeeDetails
Insert into vWEmployeeDetails values(20, 'Valarie', 'female', 'IT')
/*Msg 4405, Level 16, State 1, Line 159
View or function 'vWEmployeeDetails' is not updatable because the modification affects multiple base tables.*/

--Script to create INSTEAD OF INSERT trigger:
alter trigger tr_vWEmployeeDetails_InsteadOfInsert
on vWEmployeeDetails
Instead Of Insert
as
Begin
Declare @DeptId int
 
 --Check if there is a valid DepartmentId
 --for the given DepartmentName
 Select @DeptId = tblDepartment.Id 
 from tblDepartment 
 join inserted
 on inserted.departmentName = tblDepartment.DepartmentName
 
 --If DepartmentId is null throw an error
 --and stop processing
 if(@DeptId is null)
 Begin
  Raiserror('Invalid Department Name. Statement terminated', 16, 1)
  return
 End
 
 --Finally insert into tblEmployee table
 Insert into tblemployees(Id, firstname, Gender, DepartmentId)
 Select Id, firstname, Gender, @DeptId
 from inserted

 End

 --Inserting a record with incorrect department
 Insert into vWEmployeeDetails values(20, 'Valarie', 'female', 'ata')

 select * from vWEmployeeDetails

 --6. Insert of Update Trigger
select * from vw

