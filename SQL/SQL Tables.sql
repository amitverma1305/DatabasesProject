
CREATE TABLE [dbo].[tblDepartment](
	[Id] [int] NOT NULL primary key,
	[DepartmentName] [nvarchar](50) NOT NULL,
	[Location] [nvarchar](50) NOT NULL,
	[DepartmentHead] [nvarchar](50) NOT NULL
	)
 
CREATE TABLE [dbo].[tblemployees](
	[ID] [int] NOT NULL primary key,
	[firstname] [varchar](15) NULL,
	[lastname] [varchar](15) NULL,
	[dob] [date] NULL,
	[salary] [real] NULL,
	[city] [nvarchar](20) NULL,
	[Gender] [nchar](10) NULL,
	[DepartmentId] [int] NULL foreign key references tbldepartment(Id),
	[ManagerId] [int] NULL,
	[middlename] [varchar](50) NULL,
	[email] [varchar](50) NULL
	)

INSERT [dbo].[tblDepartment] ([Id], [DepartmentName], [Location], [DepartmentHead]) VALUES (1, N'IT', N'Chandigarh', N'Rick')
INSERT [dbo].[tblDepartment] ([Id], [DepartmentName], [Location], [DepartmentHead]) VALUES (2, N'Payroll', N'Delhi', N'Ron')
INSERT [dbo].[tblDepartment] ([Id], [DepartmentName], [Location], [DepartmentHead]) VALUES (3, N'HR', N'Mumbai', N'Christie')
INSERT [dbo].[tblDepartment] ([Id], [DepartmentName], [Location], [DepartmentHead]) VALUES (4, N'Finance', N'Punjab', N'Cindrella')
INSERT [dbo].[tblDepartment] ([Id], [DepartmentName], [Location], [DepartmentHead]) VALUES (5, N'Other Department', N'Dehradun', N'Tom')

INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (1, N'Vinod', N'Verma', CAST(N'1992-05-13' AS Date), 75000, N'Chandigarh', N'male      ', 1, 16, NULL, N'amit@aaa.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (2, N'Gagan', N'Sharma', CAST(N'1992-03-13' AS Date), 41000, N'Chandigarh', N'male      ', 1, 16, NULL, N'sparsh@sss.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (3, N'Risham', N'Kaur', CAST(N'1994-01-18' AS Date), 67000, N'Chandigarh', N'female    ', 1, 16, N'deep', N'simar@sss.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (4, N'Farhan', N'Mirza', CAST(N'1991-05-09' AS Date), 71000, N'Delhi', N'male      ', 2, 16, N'beg', N'noamn@bbb.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (5, N'Pankaj', N'Patel', CAST(N'1994-06-14' AS Date), 58000, N'Mumbai', N'male      ', 3, 17, NULL, N'nick@bbb.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (6, N'Varun', N'Sobti', CAST(N'1995-03-12' AS Date), 40000, N'Mumbai', N'female    ', 3, 17, NULL, N'gunika@sss.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (7, N'Abhishek', N'Singh', CAST(N'1991-07-21' AS Date), 60222, N'Mumbai', N'male      ', 3, 17, NULL, N'abhishek@sss.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (8, N'Mayank', N'Singh', CAST(N'1992-09-18' AS Date), 55000, N'Punjab', N'male      ', 4, 16, NULL, N'mayank@aaa.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (9, N'Nitin', N'', CAST(N'1992-05-28' AS Date), 60000, N'Punjab', N'male      ', 4, NULL, NULL, N'nitin@bbb.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (10, N'jinish', N'Patel', CAST(N'1996-07-23' AS Date), 35000, N'Gujarat', N'male      ', 4, 18, N'K.', N'jinish@aaa.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (11, N'Tarun', N'Gupta', CAST(N'1991-07-21' AS Date), 50000, N'Delhi', N'male      ', 2, 18, NULL, N'Tarun01@aaa.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (12, N'Tanvi', N'Sharma', CAST(N'1992-03-14' AS Date), 25000, N'Delhi', N'female    ', 2, 18, NULL, N'Tanvi@aaa.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (13, N'Pamel', N'Kaur', CAST(N'1992-08-24' AS Date), 35000, N'Punjab', N'female    ', 4, 2, N'preet', N'Pamel@pp.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (14, N'Sahil', N'Sareen', CAST(N'1992-11-12' AS Date), 67840, N'Gujarat', N'male      ', NULL, NULL, NULL, N'Sahil@pp.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (15, N'Varun', N'Sharma', CAST(N'1991-12-19' AS Date), 87023, N'Haryana', N'male      ', NULL, 18, N'Kumar', N'Varun@aaa.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (16, N'Josh', N'Kell', CAST(N'1981-12-14' AS Date), 120000, N'New York', N'male      ', 1, 17, NULL, N'Josh124@aaa.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (17, N'Tom', N'Riddle', CAST(N'1979-09-17' AS Date), 214000, N'New York', N'male      ', 1, 18, NULL, N'Tom@bbb.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (18, NULL, N'Hold', CAST(N'1978-02-15' AS Date), 312000, N'London', N'female    ', 2, NULL, N'Molly', N'h34@sss.com')
INSERT [dbo].[tblemployees] ([ID], [firstname], [lastname], [dob], [salary], [city], [Gender], [DepartmentId], [ManagerId], [middlename], [email]) VALUES (19, NULL, NULL, CAST(N'1980-08-01' AS Date), 20100, N'London', N'female    ', 2, 18, N'Dolly', N'Dolly@pp.com')
