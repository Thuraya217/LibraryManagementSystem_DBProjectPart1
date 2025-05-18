-- SQL FOR LIBRARY SYSTEM
create database Library 
Go
use Library

 -- staff table
create table Staff (
staff_ID int primary key,
FullName nvarchar (50) not null,
position nvarchar (50) not null ,
)

-- Staff_number table
create table Staff_number (
staff_ID int,
contact_number int not null unique,
foreign key (staff_ID) references Staff(staff_ID)
)

-- Library table
create table Library (
library_ID int primary key,
name nvarchar (50) not null unique,
location nvarchar (50),
established_year nvarchar (4)
)

-- library_contactNumber table
create table library_contactNumber (
library_ID int,
contact_number int not null unique,
foreign key (library_ID) references Library(library_ID)
)

-- alert to add library_ID to Staff table as foregin key
alter table Staff
add library_ID int foreign key references Library(library_ID)

-- Books table
create table Books (
Book_ID int primary key,
ISBN nvarchar (50) not null unique,
title nvarchar (50) not null,
genre nvarchar (50) check ( genre in ('Fiction', 'Non-fiction', 'Reference', 'Children' ) ),
price decimal (10,2) check ( price > 0),
availability_status nvarchar (50),
shelf_location nvarchar (50) not null,
library_ID int,
foreign key (library_ID) references Library(library_ID)
)


-- Members table
create table Members (
members_ID int primary key,
full_name nvarchar (50) not null,
email nvarchar (50) unique,
membership_start_date date
)


-- Members_Number table
create table Members_Number (
members_ID int,
phone_number int not null unique,
foreign key (members_ID) references Members(members_ID)
)

-- alert to add members_ID to Books table as foregin key
alter table Books
add members_ID int foreign key references Members (members_ID)

-- Loan table
create table Loan (
loan_ID int primary key,
status nvarchar (50) check ( status in ('Issued','Returned','Overdue') ),
return_date date,
due_date date not null,
loan_date date not null,
Book_ID int not null,
foreign key (Book_ID) references Books(Book_ID)
)

-- Payment table
create table Payment (
payment_ID int primary key,
payment_date date,
amount decimal (10,2) check ( amount > 0) not null,
method nvarchar (50) not null check ( method in ('cash','card') ),
loan_ID int not null,
foreign key (loan_ID) references Loan(loan_ID)
)

-- Review table
create table Review (
review_ID int primary key,
rating int check (rating between 1 and 5) not null,
comments nvarchar (100) default 'no comments',
review_date date,
members_ID int not null,
Book_ID int not null,
foreign key (Book_ID) references Books(Book_ID),
foreign key (members_ID) references Members(members_ID)
)

-- Members_Loan table
create table Members_Loan (
members_ID int,
loan_ID int,
foreign key (members_ID) references Members(members_ID),
foreign key (loan_ID) references Loan(loan_ID),
primary key (members_ID,loan_ID)
)