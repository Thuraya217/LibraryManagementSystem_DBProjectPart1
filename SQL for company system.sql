create database Companys;
GO
use Companys;

-- create Employee table
create table Employees (
Ssn int primary key,
FName varchar (20) not null,
Minit char (1) not null,
LName varchar (20) not null,
Bdate date,
Address varchar ( 255 ),
Sex char(1) CHECK (Sex IN ('M', 'F')),
Salary decimal (10,2) check (Salary > 0 ),
Super_ssn int,
Dno int,
foreign key (Super_ssn) references Employees (Ssn)
)

-- create department table
create table department (
Dnumber int primary key,
DName varchar (20) not null,
Mgr_ssn int,
Mgr_start_date date,
foreign key (Mgr_ssn) references Employees (Ssn)
)

-- alert to add members_ID to Books table as foregin key
alter table Employees
add Dno int foreign key references department (Dnumber);

-- drop Dno from Employees table
use Companys
alter table Employees 
drop column Dno;

-- create DEPT_LOCATIONS table
create table DEPT_LOCATIONS (
Dnumber int,
DLocation varchar (20),
primary key (Dnumber , DLocation),
foreign key (Dnumber) references department (Dnumber)
)

-- create project table
create table project (
PNumber int primary key,
PName varchar (20) not null,
PLocation varchar (20),
Dnum int
foreign key (Dnum) references department (Dnumber)
)

-- create Works_on table
create table Works_on (
Essn int,
Pno int,
Hours decimal (5,2),
primary key (Essn , Pno),
foreign key (Essn) references Employees (Ssn),
foreign key (Pno) references project (PNumber)
)

-- create Dependent table
create table Dependent (
Essn int,
Dependent_name int,
Sex char(1) check (Sex IN ('M', 'F')),
Bdate date,
Realtionship varchar (20),
primary key (Essn , Dependent_name),
foreign key (Essn) references Employees (Ssn),
);

-- DML, Insert real-world data, Minimum required data:
-- insert data to Employees table
insert into Employees (Ssn, FName, Minit, LName, Bdate, Address, Sex, Salary, Super_ssn, Dno)
values 
(123456789, 'John', 'D', 'Doe', '1985-05-20', '123 Main St, Anytown, USA', 'M', 75000.00, NULL, 1),
(987654321, 'Jane', 'A', 'Smith', '1990-08-15', '456 Oak St, Anytown, USA', 'F', 80000.00, 123456789, 1),
(234567890, 'Alice', 'B', 'Johnson', '1982-12-02', '789 Pine St, Othertown, USA', 'F', 60000.00, 987654321, 2),
(345678901, 'Bob', 'C', 'Williams', '1975-01-30', '101 Maple St, Villagetown, USA', 'M', 85000.00, 123456789, 1),
(456789012, 'Charlie', 'E', 'Brown', '1980-03-25', '202 Birch St, Countryside, USA', 'M', 90000.00, 987654321, 3),
(567890123, 'Emily', 'F', 'Davis', '1992-07-18', '303 Cedar St, Smalltown, USA', 'F', 55000.00, 234567890, 2),
(678901234, 'David', 'G', 'Miller', '1988-09-22', '404 Fir St, Townville, USA', 'M', 95000.00, 345678901, 3),
(789012345, 'Frank', 'H', 'Wilson', '1991-11-09', '505 Redwood St, Bigcity, USA', 'M', 70000.00, 234567890, 2),
(890123456, 'Grace', 'I', 'Moore', '1994-05-17', '606 Pinecone St, Metropolis, USA', 'F', 62000.00, 678901234, 3),
(901234567, 'Henry', 'J', 'Taylor', '1983-02-14', '707 Juniper St, Uptown, USA', 'M', 80000.00, 678901234, 1);

-- delete column Dno
use Companys
alter table Employees 
drop column Dno;

-- view Employees table
use Companys
SELECT * FROM Employees;

-- insert data to department table
insert into department (Dnumber, DName, Mgr_ssn, Mgr_start_date)
values 
(1, 'HR', 123456789, '2015-06-01'),
(2, 'IT', 987654321, '2018-03-15'),
(3, 'Finance', 234567890, '2020-11-20');

-- view department table
use Companys
SELECT * FROM department;

alter table Employees
drop constraint FK__Employees__Dno__4AB81AF0;

insert into Employees (Ssn, FName, Minit, LName, Bdate, Address, Sex, Salary, Super_ssn)
values 
(123456789, 'John', 'D', 'Doe', '1985-05-20', '123 Main St, Anytown, USA', 'M', 75000.00, NULL),
(987654321, 'Jane', 'A', 'Smith', '1990-08-15', '456 Oak St, Anytown, USA', 'F', 80000.00, 123456789),
(234567890, 'Alice', 'B', 'Johnson', '1982-12-02', '789 Pine St, Othertown, USA', 'F', 60000.00, 987654321),
(345678901, 'Bob', 'C', 'Williams', '1975-01-30', '101 Maple St, Villagetown, USA', 'M', 85000.00, 123456789),
(456789012, 'Charlie', 'E', 'Brown', '1980-03-25', '202 Birch St, Countryside, USA', 'M', 90000.00, 987654321),
(567890123, 'Emily', 'F', 'Davis', '1992-07-18', '303 Cedar St, Smalltown, USA', 'F', 55000.00, 234567890),
(678901234, 'David', 'G', 'Miller', '1988-09-22', '404 Fir St, Townville, USA', 'M', 95000.00, 345678901),
(789012345, 'Frank', 'H', 'Wilson', '1991-11-09', '505 Redwood St, Bigcity, USA', 'M', 70000.00, 234567890),
(890123456, 'Grace', 'I', 'Moore', '1994-05-17', '606 Pinecone St, Metropolis, USA', 'F', 62000.00, 678901234),
(901234567, 'Henry', 'J', 'Taylor', '1983-02-14', '707 Juniper St, Uptown, USA', 'M', 80000.00, 678901234);

-- view Employees table
use Companys
SELECT * FROM Employees;

-- insert data to department table
insert into department (Dnumber, DName, Mgr_ssn, Mgr_start_date)
values 
(1, 'HR', 123456789, '2015-06-01'),
(2, 'IT', 987654321, '2018-03-15'),
(3, 'Finance', 234567890, '2020-11-20');

-- view department table
use Companys
SELECT * FROM department;

-- insert data to DEPT_LOCATIONS table
insert into DEPT_LOCATIONS (Dnumber, DLocation)
values
(1, 'New York'),
(2, 'Los Angeles'),
(3, 'Chicago'),
(1, 'San Francisco'),
(2, 'Houston');

-- view DEPT_LOCATIONS table
use Companys
SELECT * FROM DEPT_LOCATIONS;

-- insert data to project table
insert into project (PNumber ,PName, PLocation, Dnum)
values
(101, 'Project Alpha', 'New York', 1),
(102, 'Project Beta', 'Los Angeles', 2),
(103, 'Project Gamma', 'Chicago', 3),
(104, 'Project Delta', 'San Francisco', 1),
(105, 'Project Epsilon', 'Houston', 2);

-- view project table
use Companys
SELECT * FROM project;

-- insert data to Works_on table
insert into Works_on (Essn, Pno, Hours)
values
(123456789, 101, 40.00),
(987654321, 102, 35.50),
(234567890, 103, 25.75),
(345678901, 101, 20.00),
(567890123, 104, 30.50);

-- view Works_on table
use Companys
SELECT * FROM Works_on;

-- drop Dependent table 
use Companys
drop table Dependent; 

-- create Dependent table and change Dependent_name int to Dependent_name varchar (20)
create table Dependent (
Essn int,
Dependent_name varchar (20),
Sex char(1) check (Sex IN ('M', 'F')),
Bdate date,
Realtionship varchar (20),
primary key (Essn , Dependent_name),
foreign key (Essn) references Employees (Ssn),
);

-- insert data to Dependent table
insert into Dependent (Essn, Dependent_name, Sex, Bdate, Realtionship)
values
(123456789, 'John Doe', 'M', '2010-04-15', 'Son'),
(987654321, 'Jane Smith', 'F', '2005-08-22', 'Daughter'),
(234567890, 'Alice Johnson', 'F', '2012-12-05', 'Daughter'),
(345678901, 'Bob Brown', 'M', '2013-01-30', 'Son');

-- view Dependent table
use Companys
SELECT * FROM Dependent;

-- use display
--Display all the employees Data
use Companys
select * from Employees;

-- Display the employee First name, last name, Salary 
use Companys
select FName, LName, Salary
from Employees;

-- Display all the projects names, locations and the department which is responsible about it
use Companys
select PName, PLocation , DName
from project
join department on Dnum = Dnumber;

-- If you know that the company policy is to pay an annual commission for each employee with specific percent equals 10% of his/her annual salary .Display each employee full name and his annual commission in an ANNUAL COMM column (alias).
use Companys
select FName + ' ' + LName as Full_Name,
Salary * 12  *0,10 as  [annual comm]
from Employees;

-- Display the employees Id, name who earns more than 1000 LE monthly
use Companys
select Ssn, FName, LName, Salary
from Employees
where Salary > 1000;

-- Display the employees Id, name who earns more than 10000 LE annually
use Companys
select Ssn, FName, LName, Salary
from Employees
where Salary > 10000;

-- Display the names and salaries of the female employees
use Companys
select FName, LName, Salary
from Employees
where Sex = 'F';

-- Display each department id, name which managed by a manager with id equals 987654321
use Companys
select Dnumber, DName
from department
join Employees on Mgr_ssn = Ssn
where Mgr_ssn = 987654321;

-- Dispaly the ids, names and locations of  the pojects which controled with department 1
use Companys
select PNumber ,PName, PLocation
from project
where Dnum = 1;

-- Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000
use Companys
insert into Employees
(Ssn, FName, Minit, LName, Bdate, Address, Sex, Salary, Super_ssn, Dno)
values 
( 112233, 'John', 'B', 'Doe', '1980-03-20', '456 King St, Cairo', 'M', 5000.00, NULL, 30);

--  Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or supervisor number to him. 
use Companys
insert into Employees
(Ssn, FName, Minit, LName, Bdate, Address, Sex, Salary, Super_ssn, Dno)
values 
(102660, 'Friend', 'B', 'Ali', '1994-07-25', '789 Elm St, Cairo', 'M', NULL, NULL, 30);

-- Upgrade your salary by 20 % of its last value
use Companys
update Employees
set Salary = Salary * 1.20
where Ssn = 102660;

