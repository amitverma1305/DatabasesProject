--Amit Verma
--SQL Basics
--Cast/Convert Functions
--Mathematical Functions
--Scalar User Defined Functions


--1. Cast( expression AS data_type [ ( length ) ] )
Select Id, firstname+' '+lastname, dob, CAST(dob as nvarchar) as ConvertedDOB
from tblEmployees

--2. CONVERT ( data_type [ ( length ) ] , expression [ , style ] )
Select Id, firstname+' '+lastname, dob, Convert(nvarchar, dob, 103) as ConvertedDOB
from tblEmployees
--101-105: Style Parameter

--3. ABS ( numeric_expression ) - ABS stands for absolute and returns, the absolute (positive) number. 
Select ABS(-121.45) -- returns 101.5, without the - sign.

--4. CEILING ( numeric_expression ) and FLOOR ( numeric_expression )
--CEILING and FLOOR functions accept a numeric expression as a single parameter. 
--CEILING() returns the smallest integer value greater than or equal to the parameter.
--FLOOR() returns the largest integer less than or equal to the parameter. 

Examples:
Select CEILING(15.2) -- Returns 16
Select CEILING(-15.2) -- Returns -15

--5. Power(expression, power) - Returns the power value of the specified expression to the specified power.
Select POWER(2,3) -- Returns 8

--6. Square SQUARE ( Number ) - Returns the square of the given number.

Select SQUARE(9) -- Returns 81 

--7. RAND Returns a random float number between 0 and 1. Rand() function takes an optional seed parameter. 
--When seed value is supplied the RAND() function always returns the same value for the same seed.
Select RAND(1) 

--8. ROUND ( numeric_expression , length [ ,function ] ) - Rounds the given numeric expression based on the given length. 
--This function takes 3 parameters. 
	--1. Numeric_Expression is the number that we want to round.
	--2  Length parameter, specifies the number of the digits that we want to round to. If the length is a positive number, 
	--   then the rounding is applied for the decimal part, where as if the length is negative, then the rounding is applied to the number before the decimal.
	--3. The optional function parameter, is used to indicate rounding or truncation operations. 
	--A value of 0, indicates rounding, where as a value of non zero indicates truncation. Default, if not specified is 0.

-- Round to 2 places after (to the right) the decimal point
Select ROUND(850.556, 2) -- Returns 850.560

-- Truncate anything after 2 places, after (to the right) the decimal point
Select ROUND(850.556, 2, 1) -- Returns 850.550

-- Round to 1 place after (to the right) the decimal point
Select ROUND(850.556, 1) -- Returns 850.600

-- Truncate anything after 1 place, after (to the right) the decimal point
Select ROUND(850.556, 1, 1) -- Returns 850.500

-- Round the last 2 places before (to the left) the decimal point
Select ROUND(850.556, -2) -- 900.000

-- Round the last 1 place before (to the left) the decimal point
Select ROUND(850.556, -1) -- 850.000

--9. Scalar Function

CREATE FUNCTION CalculateAge(@DOB Date)  
RETURNS INT  
AS  
BEGIN  
 DECLARE @Age INT  
 SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - 
	CASE 
		WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) 
			THEN 1 
		ELSE 0 
END  
 RETURN @Age  
END

select dbo.CalculateAge('05/13/1992') as 'Age' -- Need to use 2 part name owner_name.function_name

--10. Inline Table Valued Functions
CREATE FUNCTION fn_EmployeesByGender(@Gender nvarchar(10))
RETURNS TABLE
AS
RETURN (Select Id, firstname, dob, Gender, DepartmentId
      from tblEmployees
      where Gender = @Gender)

select * from fn_EmployeesByGender('male')

--11. Multistatement Table valued Function
Create Function fn_MSTVF_GetEmployees()
Returns @Table Table (Id int, Name nvarchar(20), DOB Date)
as
Begin
 Insert into @Table
 Select Id, firstname, Cast(dob as Date)
	From tblEmployees
 
 Return
End

select * from fn_MSTVF_GetEmployees()

--12. Deterministic and Non-Deterministic Functions

--Deterministic functions always return the same result any time they are called with a specific set of input values 
--and given the same state of the database. 
--Examples: 
 select Sum(salary), AVG(salary), Square(salary), Power(salary,.5) , Count(salary) from tblemployees
 group by salary
--All aggregate functions are deterministic functions.


--Nondeterministic functions may return different results each time they are called with a specific set of input values 
--even if the database state that they access remains the same.
--Examples: 
select GetDate() 
select CURRENT_TIMESTAMP


/* What is schema biniding?
Schemabinding, specifies that the function is bound to the database objects that it references. 
When SCHEMABINDING is specified, the base objects cannot be modified in any way that would affect the function definition. 
The function definition itself must first be modified or dropped to remove dependencies on the object that is to be modified.*/
