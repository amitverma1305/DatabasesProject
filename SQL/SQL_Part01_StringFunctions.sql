--Amit Verma
--SQL Basics
--Commonly Used String Functions

--1. ASCII(Character_Expression) - Returns the ASCII code of the given character expression.
Select Ascii('a')

--2. CHAR(Integer_Expression) - Converts an int ASCII code to a character. The Integer_Expression, should be between 0 and 255.
select char(97)

--3. LTRIM(Character_Expression) - Removes blanks on the left handside of the given character expression.
select ltrim('     Hello')

--4. RTRIM(Character_Expression) - Removes blanks on the right hand side of the given character expression.
select rtrim('Hello    ')

--5. LOWER(Character_Expression) - Converts all the characters in the given Character_Expression, to lowercase letters.
select lower('SQL BASics-CoMMonLY used STRING FUNctions')

--6. UPPER(Character_Expression) - Converts all the characters in the given Character_Expression, to uppercase letters.
select upper('SQL BASics-CoMMonLY used STRING FUNctions')

--7. REVERSE('Any_String_Expression') - Reverses all the characters in the given string expression.
select reverse('SQL')

--8. LEN(String_Expression) - Returns the count of total characters, in the given string expression, excluding the blanks at the end of the expression.
select len('my length is 15')

--Function to Print A-Z
declare @start int
set @start=65
while (@start<=90) 
begin
	print char(@start)
	set @start=@start+1
end

--9. LEFT(Character_Expression, Integer_Expression) - Returns the specified number of characters from the left hand side of the given character expression.
SELECT LEFT('Learning SQL',5)

--10. RIGHT(Character_Expression, Integer_Expression) - Returns the specified number of characters from the right hand side of the given character expression.
SELECT RIGHT('Learning SQL',3)

--11.CHARINDEX('Expression_To_Find', 'Expression_To_Search', 'Start_Location') - Returns the starting position of the specified expression in a character string. Start_Location parameter is optional.
Select CHARINDEX('@','sql@gmail.com',1)

--12. SUBSTRING('Expression', 'Start', 'Length') - This function returns substring (part of the string), from the given expression. 
--You specify the starting location using the 'start' parameter and the number of characters in the substring using 'Length' parameter. 
--All the 3 parameters are mandatory.
select SUBSTRING(email,CHARINDEX('@',email)+1,len(email)-CHARINDEX('@',email)) as 'Domain Name', count(ID) as 'Domain Count'
	from tblemployees
		group by SUBSTRING(email,CHARINDEX('@',email)+1,len(email)-CHARINDEX('@',email))

--13. REPLICATE(String_To_Be_Replicated, Number_Of_Times_To_Replicate) - Repeats the given string, for the specified number of times.
select REPLICATE('SQL ', 3)
select top 5  *,left(email,2)+REPLICATE('*',3)+SUBSTRING(email,CHARINDEX('@',email),len(email)-CHARINDEX('@',email)+1)
 from tblemployees

--14. SPACE(Number_Of_Spaces) - Returns number of spaces, specified by the Number_Of_Spaces argument.
Select space(5)
select firstname+space(5)+lastname as [Full Name] from tblemployees 

--15. Pattern Index
--Returns the staarting position of the first occurance of a pattern in a specified expression.

Select email, PATINDEX('%aaa.com',email) from tblemployees
where PATINDEX('%aaa.com',email)>0

--REPLACE(String_Expression, Pattern , Replacement_Value)	Replaces all occurrences of a specified string value with another string value.
Select email, replace(email,'.com','.net') as [Converted Email] from tblemployees

--STUFF(Original_Expression, Start, Length, Replacement_expression)
--STUFF() function inserts Replacement_expression, at the start position specified, along with removing the charactes specified using Length parameter.
select firstname,lastname,email,stuff(email,2,3,'***') as [Stuffed Email] from tblemployees