--INSERT INTO EmployeeDemographics VALUES 
--(1002, 'Pam', 'Beasley', 30, 'Female'),
--(1003, 'Dwight', 'Schrute', 29, 'Male'),
--(1004, 'Angela', 'Martin', 31, 'Female'),
--(1005, 'Toby', 'Flenderson', 32, 'Male'),
--(1006, 'Micheal', 'Scott', 35, 'Male'),
--(1007, 'Meredith', 'Palmer', 32, 'Female'),
--(1008, 'Stanley', 'Hudson', 38, 'Male'),
--(1009, 'Kevin', 'Malone', 31, 'Male')

--INSERT INTO EmployeeSalary VALUES 
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager', 65000),
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)

/*
Select Statemnet
*, Top, Distinct, Count, As, Max, Min, Avg
*/

/*Select*/

--SELECT FirstName, LastName FROM EmployeeDemographics
--SELECT TOP 5 * FROM EmployeeDemographics
--SELECT DISTINCT(GENDER) FROM EmployeeDemographics
--SELECT COUNT(LastName) FROM EmployeeDemographics
--SELECT COUNT(LastName) AS LastNameCount FROM EmployeeDemographics // As is naming the render
--SELECT MIN(Salary) FROM EmployeeSalary
--SELECT MAX(Salary) FROM EmployeeSalary
--SELECT AVG(Salary) FROM EmployeeSalary

/*Select from the master branch*/
--SELECT * FROM [SQL tutorial].dbo.EmployeeSalary


/*
Where Statment
=, <>, <, >,And , OR, LIKE, NULL, NOT NULL, IN
*/

--SELECT * FROM EmployeeDemographics WHERE FirstName = 'Jim'
--SELECT * FROM EmployeeDemographics WHERE FirstName <> 'Jim'
--SELECT * FROM EmployeeDemographics WHERE Age >= 30
--SELECT * FROM EmployeeDemographics WHERE Age <= 32 AND Gender = 'Male'
--SELECT * FROM EmployeeDemographics WHERE LastName LIKE 'S%' // Start with S
--SELECT * FROM EmployeeDemographics WHERE LastName LIKE '%S%' // have an s in it
--SELECT * FROM EmployeeDemographics WHERE LastName LIKE 'S%c%o%' // Start with S and has an c in it the an o in it
--SELECT * FROM EmployeeDemographics WHERE FirstName is NULL // or NOT NULL
--SELECT * FROM EmployeeDemographics WHERE FirstName in ('Jim', 'Micheal') // it is equal for multiple things


/*
GROUP BY, ORDER BY
*/

SELECT Gender,Age, COUNT(Gender) AS 'Gender Count' FROM EmployeeDemographics GROUP BY Gender, Age // select the gender and age and group them as if those who have the same gender and age
SELECT Gender, COUNT(Gender) AS 'Gender Count' FROM EmployeeDemographics WHERE Age > 31 GROUP BY Gender
SELECT Gender, COUNT(Gender) AS CountGender FROM EmployeeDemographics WHERE Age > 31 GROUP BY Gender ORDER BY CountGender DESC // Or ASC
SELECT Gender, COUNT(Gender) AS CountGender FROM EmployeeDemographics WHERE Age > 31 GROUP BY Gender ORDER BY Gender DESC
SELECT * FROM EmployeeDemographics ORDER BY Age DESC, Gender DESC // is going to order by age at first and those in the same order by age is going to order them by gender
SELECT * FROM EmployeeDemographics ORDER BY 4 DESC, 5 DESC // the same as using the colums name


/*

Inner Joins, Full/left/right/ outer Joins

*/

--SELECT * FROM [SQL tutorial].dbo.EmployeeDemographics

--SELECT * FROM [SQL tutorial].dbo.EmployeeSalary

SELECT * FROM [SQL tutorial].dbo.EmployeeDemographics Join [SQL tutorial].dbo.EmployeeSalary ON EmployeeDemographics.EmpoyeeID = EmployeeSalary.EmployeeID // join the same ids

SELECT * FROM [SQL tutorial].dbo.EmployeeDemographics Full Outer Join [SQL tutorial].dbo.EmployeeSalary ON EmployeeDemographics.EmpoyeeID = EmployeeSalary.EmployeeID // match the 2 tables with the is if the ids are not the same it will join the other with the null row

SELECT * FROM [SQL tutorial].dbo.EmployeeDemographics Left Outer Join [SQL tutorial].dbo.EmployeeSalary ON EmployeeDemographics.EmpoyeeID = EmployeeSalary.EmployeeID --match the left table with the right table with the is if the ids are not the same it will join the other with the null row

SELECT EmployeeDemographics.EmpoyeeID, FirstName, LastName, Age, JobTItle, Salary  FROM [SQL tutorial].dbo.EmployeeDemographics Left Outer Join [SQL tutorial].dbo.EmployeeSalary ON EmployeeDemographics.EmpoyeeID = EmployeeSalary.EmployeeID 

SELECT EmployeeDemographics.EmpoyeeID, FirstName, LastName, Salary FROM [SQL tutorial].dbo.EmployeeDemographics Inner Join [SQL tutorial].dbo.EmployeeSalary ON EmployeeDemographics.EmpoyeeID = EmployeeSalary.EmployeeID WHERE FirstName <> 'Micheal' ORDER BY Salary DESC

SELECT JobTItle, Salary FROM [SQL tutorial].dbo.EmployeeDemographics Inner Join [SQL tutorial].dbo.EmployeeSalary ON EmployeeDemographics.EmpoyeeID = EmployeeSalary.EmployeeID WHERE JobTItle = 'Salesman' ORDER BY Salary DESC

SELECT JobTItle, AVG(Salary) AS AverageSalary FROM [SQL tutorial].dbo.EmployeeDemographics Inner Join [SQL tutorial].dbo.EmployeeSalary ON EmployeeDemographics.EmpoyeeID = EmployeeSalary.EmployeeID WHERE JobTItle = 'Salesman' GROUP BY JobTItle 

/*
UNION, UNION ALL
*/

SELECT * FROM [SQL tutorial].dbo.EmployeeDemographics UNION SELECT * FROM [SQL tutorial].dbo.WareHouseEmployeeDemographics -- union the 2 tables and delete the duplicates

SELECT * FROM [SQL tutorial].dbo.EmployeeDemographics UNION ALL SELECT * FROM [SQL tutorial].dbo.WareHouseEmployeeDemographics ORDER BY EmpoyeeID -- union the 2 tables with the duplicates


SELECT * FROM [SQL tutorial].dbo.EmployeeDemographics Full Outer Join [SQL tutorial].dbo.WareHouseEmployeeDemographics ON EmployeeDemographics.EmpoyeeID = WareHouseEmployeeDemographics.EmployeeID

/*
Case Statement
*/

SELECT FirstName, LastName, Age, 
CASE
	WHEN Age > 30 THEN 'Old'
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
END
FROM [SQL tutorial].dbo.EmployeeDemographics WHERE Age is NOT NULL ORDER BY Age


SELECT FirstName, LastName, JobTItle, Salary,
CASE
	WHEN JobTItle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTItle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTItle = 'HR' THEN Salary + (Salary * .0001)
	ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM [SQL tutorial].dbo.EmployeeDemographics JOIN [SQL tutorial].dbo.EmployeeSalary ON EmployeeDemographics.EmpoyeeID = EmployeeSalary.EmployeeID


/*
Having Clause
*/

SELECT JobTItle, AVG(Salary) 
FROM [SQL tutorial].dbo.EmployeeDemographics 
JOIN [SQL tutorial].dbo.EmployeeSalary 
	ON EmployeeDemographics.EmpoyeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary) 


/*
Updating/ deleting data
*/

SELECT * FROM [SQL tutorial].dbo.EmployeeDemographics

UPDATE [SQL tutorial].dbo.EmployeeDemographics SET EmpoyeeID = 1012 WHERE FirstName = 'Holly' AND LastName = 'Flax'

UPDATE [SQL tutorial].dbo.EmployeeDemographics SET Age = 31, Gender = 'Female' WHERE FirstName = 'Holly' AND LastName = 'Flax'

DELETE FROM [SQL tutorial].dbo.EmployeeDemographics WHERE EmpoyeeID = 1005


/*
Aliasing
*/

SELECT FirstName + ' ' + LastName AS FullName FROM [SQL tutorial].dbo.EmployeeDemographics

SELECT AVG(Age) AS AvgAge FROM [SQL tutorial].dbo.EmployeeDemographics

SELECT Demo.EmpoyeeID, Sal.Salary FROM [SQL tutorial].dbo.EmployeeDemographics AS Demo
JOIN [SQL tutorial].dbo.EmployeeSalary AS Sal 
	ON Demo.EmpoyeeID = Sal.EmployeeID

SELECT Demo.EmpoyeeID,Demo.FirstName, Demo.LastName, Sal.Salary, Ware.Age 
FROM [SQL tutorial].dbo.EmployeeDemographics AS Demo
LEFT JOIN [SQL tutorial].dbo.EmployeeSalary AS Sal 
	ON Demo.EmpoyeeID = Sal.EmployeeID
LEFT JOIN [SQL tutorial].dbo.WareHouseEmployeeDemographics AS Ware
	ON Demo.EmpoyeeID = Ware.EmployeeID

/*
Partition By
*/

SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM [SQL tutorial].dbo.EmployeeDemographics dem
JOIN [SQL tutorial].dbo.EmployeeSalary sal
	ON dem.EmpoyeeID = sal.EmployeeID

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender)
FROM [SQL tutorial].dbo.EmployeeDemographics dem
JOIN [SQL tutorial].dbo.EmployeeSalary sal
	ON dem.EmpoyeeID = sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary

SELECT Gender, COUNT(Gender)
FROM [SQL tutorial].dbo.EmployeeDemographics dem
JOIN [SQL tutorial].dbo.EmployeeSalary sal
	ON dem.EmpoyeeID = sal.EmployeeID
GROUP BY Gender

/*
CTE's Commun Table Expression
*/

WITH CTE_Employee as 
(SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
, AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
FROM [SQL tutorial].dbo.EmployeeDemographics dem
JOIN [SQL tutorial].dbo.EmployeeSalary sal
	ON dem.EmpoyeeID = sal.EmployeeID
WHERE Salary > '45000'
)
Select FirstName, AvgSalary FROM CTE_Employee


/*
Temp Tables
*/

CREATE TABLE #temp_Employee (
Employee_Id int,
JobTitle varchar(100),
Salary int
)

Select * FROM #temp_Employee

Select * FROM [SQL tutorial].dbo.EmployeeSalary

INSERT INTO #temp_Employee VALUES 
(1001, 'HR', 45000),
(1002, 'Salesman', 35000)

INSERT INTO #temp_Employee
SELECT * 
FROM [SQL tutorial].dbo.EmployeeSalary



DROP TABLE IF EXISTS #Temp_Employee2 -- to rerun it with no error having the table already
CREATE TABLE #Temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int,
)

INSERT INTO #Temp_Employee2
SELECT JobTItle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM [SQL tutorial].dbo.EmployeeDemographics emp
JOIN [SQL tutorial].dbo.EmployeeSalary sal
	ON emp.EmpoyeeID = sal.EmployeeID
GROUP BY JobTItle

SELECT * FROM #Temp_Employee2



/*
String functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
*/

-- Drop Table EmployeeErrors

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50)
)

INSERT INTO EmployeeErrors Values
('1001','Jimbo','Halber'),
('1002','Pamela','Beasely'),
(' 1004','Med','Mhir '),
('1005','Toby','Flenderson - Fired')


Select * From EmployeeErrors

-- Using Trim, LTRIM, RTRIM

Select EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

Select EmployeeID, LTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

Select EmployeeID, RTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors


-- Using Replace

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors

-- Using Substring

Select SUBSTRING(FirstName, 3, 3)
FROM EmployeeErrors

Select * FROM EmployeeErrors

INSERT INTO EmployeeDemographics VALUES
(1005, 'Toby', 'Flenderson', 33, 'Male')

Select err.FirstName, SUBSTRING(err.FirstName,1,3), dem.FirstName,  SUBSTRING(dem.FirstName,1,3)
FROM EmployeeErrors AS err
JOIN EmployeeDemographics AS dem
	ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)

-- Using UPPER and LOWER

Select FirstName, LOWER(FirstName)
FROM EmployeeErrors

Select FirstName, UPPER(FirstName)
FROM EmployeeErrors

/*
Stored Precedures
*/

GO -- GO indique au moteur que ce qui suit est un nouveau lot (batch)
CREATE OR ALTER PROCEDURE TEST
AS
BEGIN
    SELECT * FROM EmployeeDemographics;
END
GO


EXEC TEST -- executethe procedure



GO
CREATE PROCEDURE Temp_Employee_with_params
@JobTitle nvarchar(100)
AS
BEGIN

CREATE TABLE #Temp_Employee3 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int,
)

INSERT INTO #Temp_Employee3
SELECT JobTItle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM [SQL tutorial].dbo.EmployeeDemographics emp
JOIN [SQL tutorial].dbo.EmployeeSalary sal
	ON emp.EmpoyeeID = sal.EmployeeID
Where JobTItle = @JobTitle
GROUP BY JobTItle

SELECT * FROM #Temp_Employee3


END
GO


EXEC Temp_Employee_with_params @JobTitle = 'Salesman'-- Execute with a parameter


/*
Subqueries (in the Select, From, and Where statment)
*/

Select * From EmployeeSalary

-- Subquery in Select
Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
From EmployeeSalary

-- How to do it with Partition By
Select EmployeeID, Salary, AVG(Salary) over() as AllAvgSalary
From EmployeeSalary

-- Why Group By doesn't work
Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
Order By 1,2

-- Subquery in From

Select a.EmployeeID, AllAvgSalary From (
Select EmployeeID, Salary, AVG(Salary) over() as AllAvgSalary
From EmployeeSalary
) a


-- Subquery in WHere
Select EmployeeID,JobTItle, Salary
From EmployeeSalary 
Where EmployeeID in (
	Select EmpoyeeID From EmployeeDemographics Where Age > 30
)