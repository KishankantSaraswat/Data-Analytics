--Create Table EmployeDemographics
--(EmployeeID int,
--FirstName varchar(50),
--LastName varchar(50),
--Age int,
--Gender varchar(50)
--)

--Create Table EmployeeSalary
--(EmployeeID int,
--JobTitle varchar(50),
--Salary int)

--Insert into EmployeDemographics values
--(1001,'kk','saraswat','21','male'),
--(1002,'ram','sharma','33','male'),
--(1003,'kanishka','idiot','90','female'),
--(1004,'sujal','chutiya','75','third party'),
--(1005,'vaibhav','katua','12','female')

--Insert into EmployeeSalary values
--(1001,'software eng',100000000),
--(1002,'salesman',750000),
--(1003,'Supplier Relations',41000),
--(1004,'kinar',150),
--(1005,'Receptionist',3600)

--select Top 2 * from EmployeDemographics

--select Distinct(EmployeeID) from EmployeDemographics

--select Distinct(Gender) from EmployeDemographics

--select  Distinct(count(EmployeeID)) as LastNameCount from EmployeDemographics

--select * from EmployeeSalary

--select max(Salary)  from EmployeeSalary

--select AVG(Salary)as average from EmployeeSalary





--lecture 3 

--where statement 
--=,<>,<,>,And,Or,Like,Null,Not NUll,IN

--select * from EmployeDemographics
--where FirstName='Kanishka'

--select * from EmployeDemographics
--where FirstName<>'Kanishka'

--select * from EmployeDemographics
--where Age>21

--select * from EmployeDemographics
--where Age>=21

--select * from EmployeDemographics
--where Age>21 And Gender='Male'

--select * from EmployeDemographics
--where Age>21 Or Gender='Male'

--select * from EmployeDemographics
--where LastName Like 's%'

--select * from EmployeDemographics
--where LastName Like '%s%'

--select * from EmployeDemographics
--where LastName Like 's%w%'

--select * from EmployeDemographics
--where FirstName is Not NUll

--select * from EmployeDemographics
--where FirstName is NUll

--select * from EmployeDemographics
--where FirstName in ('Jim','idiot','kk')








