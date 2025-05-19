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

-- DML, Insert real-world data, Minimum required data:
-- insert 2–3 Libraries
insert into Library (library_ID, name, location, established_year)
values 
(1,'Central City Library', 'Downtown', '1985'),
(2, 'North Branch Library', 'Northside', '1995'),
(3, 'East Side Library', 'East District', '2001');

-- view Library table
use Library
SELECT * FROM Library;

-- insert 10+ Books
insert into Books (Book_ID,ISBN,title,genre,price,availability_status,shelf_location,library_ID,members_ID)
values
(1, '978-0140449136', 'The Odyssey', 'Fiction', 9.99, 'Available', 'A1', 1, NULL),
(2, '978-0141439518', 'Jane Eyre', 'Fiction', 12.50, 'Available', 'B2', 1,	NULL),
(3, '978-0199535569', 'Hamlet', 'Fiction', 7.80, 'Issued', 'C3', 2, 1),
(4, '978-0131103627', 'C Programming Language', 'Reference', 45.00, 'Available', 'D1', 2, NULL),
(5, '978-0545010221', 'Harry Potter 7', 'Children', 25.99, 'Overdue', 'E5', 3, 2),
(6, '978-0262033848', 'Algorithms Intro', 'Reference', 89.75, 'Available', 'F2', 3, NULL),
(7, '978-1503280786', 'Pride & Prejudice', 'Fiction', 10.00, 'Issued', 'B1', 1, 3),
(8, '978-0525566151', 'Becoming', 'Non-fiction', 18.99, 'Available', 'G3', 1, NULL),
(9, '978-0307476708', 'Thinking Fast & Slow', 'Non-fiction', 16.50, 'Available', 'H4', 3, NULL),
(10, '978-0590353427', 'Harry Potter 1', 'Children', 22.99, 'Returned', 'E1', 2, 2);

-- view Books table
use Library
SELECT * FROM Books;

-- to view the data in the table
use Library
SELECT * FROM Books WHERE Book_ID = 1;

-- insert 6+ Members
insert into Members (members_ID,full_name,email,membership_start_date)
values
(1, 'Alice Johnson', 'alice.johnson@example.com', '2023-01-15'),
(2, 'Bob Smith', 'bob.smith@example.com', '2022-11-20'),
(3, 'Carla Gomez', 'carla.gomez@example.com', '2023-03-10'),
(4, 'Daniel Lee', 'daniel.lee@example.com', '2021-06-05'),
(5, 'Eva Chen', 'eva.chen@example.com', '2024-07-01'),
(6, 'Frank Martin', 'frank.martin@example.com', '2020-09-30');

-- view Books table
use Library
SELECT * FROM Members;

-- drop Members table
use Library
drop table Members;

-- insert 8–10 Loans 
insert into Loan (loan_ID,status,return_date,due_date,loan_date,Book_ID)
values
(1, 'Returned', '2024-06-01', '2024-05-30', '2024-05-15', 1),
(2, 'Overdue', NULL, '2024-05-10', '2024-04-25', 2),
(3, 'Returned', '2024-04-20', '2024-04-18', '2024-04-01', 3),
(4, 'Issued', NULL, '2024-06-10', '2024-05-19', 4),
(5, 'Returned', '2024-03-28', '2024-03-25', '2024-03-10', 5),
(6, 'Overdue', NULL, '2024-05-01', '2024-04-15', 6),
(7, 'Issued', NULL, '2024-06-05', '2024-05-18', 7),
(8, 'Returned', '2024-02-10', '2024-02-08', '2024-01-25', 8),
(9, 'Returned', '2024-05-01', '2024-04-30', '2024-04-10', 9),
(10, 'Issued', NULL, '2024-06-15', '2024-05-19', 10);

-- view Loan table
use Library
SELECT * FROM Loan;

-- view 4+ Payment
insert into Payment (payment_ID,payment_date,amount,method,loan_ID)
values
(1, '2024-06-01', 50.00, 'cash', 1),
(2, '2024-06-03', 75.50, 'card', 2),
(3, '2024-06-05', 30.00, 'cash', 3),
(4, '2024-06-07', 100.00, 'card', 4),
(5, '2024-06-09', 60.25, 'cash', 5);

-- view Payment table
use Library
SELECT * FROM Payment;

-- insert 4+ Staff 
insert into Staff (staff_ID,FullName,position,library_ID)
values
(1, 'Ahmed Saeed', 'Librarian', 1),
(2, 'Mona Ali', 'Assistant Librarian', 1),
(3, 'Khaled Omar', 'Archivist', 2),
(4, 'Sara Youssef', 'IT Support', 2),
(5, 'Yasser Nabil', 'Security', 1);

-- view Staff table
use Library
SELECT * FROM Staff;

-- insert 6+ Reviews 
insert into Review (review_ID,rating,comments,review_date,members_ID,Book_ID)
values
(1, 5, 'Great book!', '2024-06-01', 1, 1),
(2, 4, 'Interesting read, but a bit long.', '2024-06-02', 2, 3),
(3, 3, 'Good, but could have been better.', '2024-06-03', 3, 2),
(4, 5, 'Loved it! Highly recommend.', '2024-06-05', 4, 5),
(5, 2, 'Not my cup of tea.', '2024-06-07', 5, 7),
(6, 4, 'Nice plot, but the ending was predictable.', '2024-06-08', 6, 8);

-- view Review table
use Library
SELECT * FROM Review;

-- Use DML to simulate real application behavior:
-- Mark books as returned
use Library
update Loan
set status = 'Returned', return_date = getdate()
where Book_ID = 3;

-- Update loan status
use Library
update Loan 
set status = 'Returned'
where loan_ID = 2;

-- Delete reviews/payments 
-- Delete from reviews
use Library
delete from Review
where review_ID = 6 

-- Delete from payments
use Library
delete from Payment
where payment_ID = 5

