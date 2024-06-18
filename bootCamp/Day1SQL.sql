Create Table EmployeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

Create Table EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int)

Insert into EmployeDemographics values
(1001,'kk','saraswat','21','male'),
(1002,'ram','sharma','33','male'),
(1003,'kanishka','idiot','90','female'),
(1004,'sujal','chutiya','75','third party'),
(1005,'vaibhav','katua','12','female')

Insert into EmployeeSalary values
(1001,'software eng',100000000),
(1002,'salesman',750000),
(1003,'Supplier Relations',41000),
(1004,'kinar',150),
(1005,'Receptionist',3600)

select Top 2 * from EmployeDemographics

select Distinct(EmployeeID) from EmployeDemographics

select Distinct(Gender) from EmployeDemographics

select  Distinct(count(EmployeeID)) as LastNameCount from EmployeDemographics

select * from EmployeeSalary

select max(Salary)  from EmployeeSalary

select AVG(Salary)as average from EmployeeSalary





-- lecture 3 

-- where statement 
-- =,<>,<,>,And,Or,Like,Null,Not NUll,IN

select * from EmployeDemographics
where FirstName='Kanishka'

select * from EmployeDemographics
where FirstName<>'Kanishka'

select * from EmployeDemographics
where Age>21

select * from EmployeDemographics
where Age>=21

select * from EmployeDemographics
where Age>21 And Gender='Male'

select * from EmployeDemographics
where Age>21 Or Gender='Male'

select * from EmployeDemographics
where LastName Like 's%'

select * from EmployeDemographics
where LastName Like '%s%'

select * from EmployeDemographics
where LastName Like 's%w%'

select * from EmployeDemographics
where FirstName is Not NUll

select * from EmployeDemographics
where FirstName is NUll

select * from EmployeDemographics
where FirstName in ('Jim','idiot','kk')



------------------------------------------------------------------------------------

Day 2
Group by and oredr BY

select Gender,Age ,Count(Gender) From EmployeDemographics
Group by Gender,Age

select Gender,Age ,Count(Gender) From EmployeDemographics
where Age>31
Group by Gender,Age

select Gender,Count(Gender) as counterGender From EmployeDemographics
where Age>5
Group by Gender
Order by counterGender desc

select * from EmployeDemographics
order by 3 desc,2 desc



-----------------------------------------------
-- JOINS

Inner Join Full/Right/Left/outer Joins

select * from EmployeDemographics
Inner Join EmployeeSalary
On EmployeDemographics.EmployeeID=EmployeeSalary.EmployeeID

select * from EmployeDemographics
full outer Join EmployeeSalary
On EmployeDemographics.EmployeeID=EmployeeSalary.EmployeeID

select * from EmployeDemographics
Left outer Join EmployeeSalary
On EmployeDemographics.EmployeeID=EmployeeSalary.EmployeeID

select * from EmployeDemographics
Right outer Join EmployeeSalary
On EmployeDemographics.EmployeeID=EmployeeSalary.EmployeeID

select EmployeeID,FirstName,Age,Salary from EmployeDemographics
Inner Join EmployeeSalary
On EmployeDemographics.EmployeeID=EmployeeSalary.EmployeeID


-- this is not good at all 

select EmployeDemographics.EmployeeID,FirstName,Age,Salary from EmployeDemographics
Inner Join EmployeeSalary
On EmployeDemographics.EmployeeID=EmployeeSalary.EmployeeID

-- q1 find name of employee which got hight salary except kk

select EmployeDemographics.EmployeeID,FirstName,LastName,Salary from EmployeDemographics
Inner Join EmployeeSalary
On EmployeDemographics.EmployeeID=EmployeeSalary.EmployeeID
where FirstName <> 'kk'
order by Salary Desc 

-- q2 Average salary for SalesMan

select Avg(Salary) as salary from EmployeDemographics
Inner Join EmployeeSalary
On EmployeDemographics.EmployeeID=EmployeeSalary.EmployeeID
where JobTitle='salesMan'

------------------------------------------------------------------------------


Create Table WareHouseEmployee
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

Insert into WareHouseEmployee Values
(1211,'krishna','sharma',87,'male'),
(5211,'krish','sharma',78,'male'),
(1011,'alex','sharma',45,'male'),
(1241,'james','bond',36,'male')


select * from WareHouseEmployee
Full outer Join EmployeDemographics
On WareHouseEmployee.EmployeeID=EmployeDemographics.EmployeeID


select * from WareHouseEmployee
Union
select * from EmployeDemographics

select * from WareHouseEmployee
Union All --its give every row of both table but union give all values of table except duplicate values
select * from EmployeDemographics
order by EmployeeID

select EmployeeID,FirstName,Age from EmployeDemographics
Union 
select EmployeeID,JobTitle,Salary from EmployeeSalary

-------------
-- CASEBASED
----------------

SELECT 
   FirstName,
   LastName,
   Age,
   CASE
When Age Between 21 And 32 then 'young'
when Age< 15 then 'baby'
       WHEN Age > 33 THEN 'old'
       ELSE 'Young'
   END AS AgeCategory
FROM 
   EmployeDemographics
ORDER BY 
   Age;

Case 2 Salary Raise
SELECT ed.FirstName,ed.LastName,es.JobTitle,es.Salary,
CASE
WHEN es.JobTitle = 'salesman' THEN es.Salary + (es.Salary * 0.10)
WHEN es.JobTitle = 'kinar' THEN es.Salary + (es.Salary * 0.025)
ELSE es.Salary + (es.Salary * 0.3)
END AS NewSalary
FROM EmployeDemographics ed
FULL OUTER JOIN EmployeeSalary es
ON ed.EmployeeID = es.EmployeeID;


-- Having Clause

select JobTitle,Count(JobTitle) as c from EmployeDemographics as ed
full outer join
EmployeeSalary as es
ON ed.EmployeeID=es.EmployeeID
---where count(JobTitle)>1 ---An aggregate may not appear in the WHERE clause unless it is in a subquery contained in
---a HAVING clause or a select list, and the column being aggregated is an outer reference.
Group by (JobTitle)

Having count(JobTitle)>1



select JobTitle,Avg(Salary) as c from EmployeDemographics as ed
full outer join
EmployeeSalary as es
ON ed.EmployeeID=es.EmployeeID
---where count(JobTitle)>1 ---An aggregate may not appear in the WHERE clause unless it is in a subquery contained in
---a HAVING clause or a select list, and the column being aggregated is an outer reference.
Group by (JobTitle)
Having Avg(Salary)>500000
order by Avg(Salary) desc



---------------

-- updating & deleting 

select * from EmployeDemographics

update EmployeDemographics
set age=19 , EmployeeID=1032
where FirstName='kanishka'


select * from EmployeDemographics
update EmployeDemographics
set FirstName='Teena',LastName='null',Age=20,Gender='female'
where EmployeeID=1002

Delete from EmployeDemographics where FirstName='vaibhav'


----Aliasing

select FirstName + ' ' + LastName as fullName from EmployeDemographics

select * from EmployeDemographics as a
full outer join 
EmployeeSalary as b
On b.EmployeeID=a.EmployeeID
full outer join 
WareHouseEmployee as c
on c.EmployeeID=a.


----------
-- partition By

select FirstName,LastName,Gender,Salary
,Count(Gender) over (partition by Gender) as TotalGender
from EmployeDemographics
Join
EmployeeSalary
On EmployeDemographics.EmployeeID=EmployeeSalary.EmployeeID

select FirstName,LastName,Gender,Salary,Count(Gender) 
from EmployeDemographics
Join
EmployeeSalary
On EmployeDemographics.EmployeeID=EmployeeSalary.EmployeeID

group by FirstName,LastName,Gender,Salary


-------------------------------------------

-- 
-- CTEs 

































------


-- Temp Table

Create Table #tempTable(
EmployeeId int,
JobTitle varchar(50),
Salary int)

Insert into #tempTable
select * from EmployeeSalary

select * from #tempTable

create table #temptable2(
JobTitle varchar(50),
EmployeePerJob int,
AverageAge int,
AvgSalary int)


select * from EmployeDemographics
Insert into #temptable2
Select JobTitle,Count(Jobtitle),Avg(Age),Avg(Salary)
from EmployeDemographics as ed
Join EmployeeSalary as es
on es.EmployeeID=ed.EmployeeID
group by JobTitle


select * from #temptable2


-- String function Trim,Ltrim,rtrim,replace,substring,upper,lower

select * from EmployeDemographics

create table employeErrors(
EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50)
)

INSERT INTO employeErrors (EmployeeID, FirstName, LastName) VALUES
('1001 ', 'kkji', 'saraswatji'),
(' 1002', 'Teen', 'kumari'),
('1004', 'sujAL', 'Chutiya');

select * from employeErrors

select EmployeeID,TRIM(EmployeeID) from employeErrors
select EmployeeID,LTRIM(EmployeeID) from employeErrors
select EmployeeID,RTRIM(EmployeeID) from employeErrors

---using replace

select LastName,REPLACE(LastName,'kumari','')as LastNameFixed from employeErrors

--using substring 
--select SUBSTRING(FirstName(1,3) from employeErrors

SELECT SUBSTRING(FirstName, 1, 3) AS FirstThreeChars
FROM employeErrors;


--using upper & lower

select FirstName,Lower(FirstName) from employeErrors


select FirstName,Upper(FirstName) from employeErrors







