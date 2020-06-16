--Amit Verma
--SQL Basics
--Commonly Used DateTime Functions

--1. DateTime data types
--2. DateTime functions available to select the current system date and time
--3. Understanding concepts - UTC time and Time Zone offset
CREATE TABLE [tblDateTime]
(
 [c_time] [time](7) NULL,
 [c_date] [date] NULL,
 [c_smalldatetime] [smalldatetime] NULL,
 [c_datetime] [datetime] NULL,
 [c_datetime2] [datetime2](7) NULL,
 [c_datetimeoffset] [datetimeoffset](7) NULL
) 
INSERT INTO tblDateTime VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())

--1. Viewing Date Time in different formats
select * from tblDateTime

--2. ISDATE() - Checks if the given value, is a valid date, time, or datetime. Returns 1 for success, 0 for failure.
Select ISDATE('Data') -- returns 0
Select ISDATE(Getdate()) -- returns 1
Select ISDATE('2020-06-14 11:10:04.101') -- returns 1

--3. Day() - Returns the 'Day number of the Month' of the given date
Select DAY(GETDATE()) -- Returns the day number of the month, based on current system datetime.
Select DAY('06/14/2020') -- Returns 14

--4. Month() - Returns the 'Month number of the year' of the given date
Select Month(GETDATE()) -- Returns the Month number of the year, based on the current system date and time
Select Month('06/14/2020') -- Returns 06

--5. Year() - Returns the 'Year number' of the given date
Select Year(GETDATE()) -- Returns the year number, based on the current system date
Select Year('06/14/2020') -- Returns 2020

--6. DateName(DatePart, Date) - Returns a string, that represents a part of the given date. This functions takes 2 parameters. 
--The first parameter 'DatePart' specifies, the part of the date, we want. The second parameter, is the actual date, from which 
--we want the part of the Date.
Select DATENAME(Day, '06/14/2020 10:26:46.837') -- Returns 14
Select DATENAME(WEEKDAY, '06/14/2020 10:26:46.837') -- Returns Sunday
Select DATENAME(MONTH, '06/14/2020 10:26:46.837') -- Returns June

--Run Table_SQL Script in order to run the below query:
https://github.com/amitverma1305/Projects/blob/master/SQL/SQL%20Tables.sql

Select * from tblemployees

Select firstname, dob, DateName(WEEKDAY,dob) as [Day], 
            Month(dob) as MonthNumber, 
            DateName(MONTH, dob) as [MonthName],
            Year(dob) as [Year]
From   tblEmployees

--7.DatePart(DatePart, Date) - Returns an integer representing the specified DatePart. 
--This function is simialar to DateName(). DateName() returns nvarchar, where as DatePart() returns an integer. 
--The valid DatePart parameter values are shown below. 
Select DATEPART(weekday, '06/14/2020 10:26:46.837') -- returns 1
Select DATENAME(weekday, '06/14/2020 10:26:46.837') -- returns Sunday


--8. DATEADD (datepart, NumberToAdd, date) - Returns the DateTime, after adding specified NumberToAdd, 
--to the datepart specified of the given date.

Examples:
Select DateAdd(DAY, 10, '06/14/2020 10:26:46.837') -- Returns 2020-06-24 10:26:46.837
Select DateAdd(DAY, -10, '06/14/2020 10:26:46.837') -- Returns 2020-06-24 10:26:46.837

--9. DATEDIFF(datepart, startdate, enddate) - Returns the count of the specified datepart boundaries crossed between the specified 
--startdate and enddate.

Examples:
Select DATEDIFF(MONTH, '05/31/2020','06/14/2020') -- returns 1
Select DATEDIFF(DAY, '05/31/2020','06/14/2020') -- returns 14
