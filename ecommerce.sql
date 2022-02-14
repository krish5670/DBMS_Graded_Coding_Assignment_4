show databases;

create database if not exists ecommerce;
use ecommerce;
create table if not exists supplier(
SUPP_ID int primary key auto_increment, 
SUPP_NAME varchar (50), 
SUPP_CITY varchar (50), 
SUPP_PHONE bigint);

desc supplier;
create table if not exists Customer (
CUST_ID int primary key auto_increment, 
CUS_NAME varchar(50), 
CUS_PHONE bigint, 
CUS_CITY varchar(50), 
CUS_GENDER varchar (10));
desc Customer;
create table if not exists Category (
CAT_ID int primary key auto_increment, 
CAT_NAME varchar(50));
desc Category;

create table if not exists Product (
PRO_ID int primary key auto_increment, 
PRO_NAME varchar(50), 
PRO_DESC varchar(100),
CAT_ID int, 
foreign key (CAT_ID) references Category(CAT_ID));
desc Product;
create table if not exists ProductDetails (
PROD_ID int primary key auto_increment,
PRO_ID int, 
foreign key (PRO_ID) references Product(PRO_ID),
SUPP_ID int, 
foreign key (SUPP_ID) references supplier(SUPP_ID), 
PRICE double );
desc ProductDetails;
create table if not exists Orders (
ORD_ID int primary key auto_increment, 
Amount double, 
ORD_DATE date,
CUST_ID int, 
foreign key (CUST_ID) references Customer(CUST_ID),
PROD_ID int, 
foreign key (PROD_ID) references ProductDetails(PROD_ID));
desc Orders;
create table if not exists Rating (
RAT_ID int primary key auto_increment,
CUST_ID int, 
foreign key (CUST_ID) references customer(CUST_ID), 
SUPP_ID int,
foreign key (SUPP_ID) references supplier(SUPP_ID), 
RAT_RATSTARS int);
desc Rating;
insert into supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Rajesh Retails', 'Delhi','1234567890');
desc supplier;
insert into supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Appario Ltd', 'Mumbai','2589631470');
insert into supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Knome products', 'Bangalore','9785462315');
insert into supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Bansal Retails', 'Kochi','8975463285');
insert into supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Mittal Ltd', 'Lucknow','7898456532');

select* from supplier;
insert into Customer (CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) values ('AAKASH', '9999999999','DELHI','M');
insert into Customer (CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) values ('AMAN', '9785463215','NOIDA','M');
insert into Customer (CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) values ('NEHA', '9999999999','MUMBAI','F');
insert into Customer (CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) values ('MEGHA', '9994562399','KOLKATA','F');
insert into Customer (CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) values ('PULKIT', '7895999999','LUCKNOW','M');
select*from Customer;

insert into Category (CAT_NAME) values ('BOOKS');
insert into Category (CAT_NAME) values ('GAMES');
insert into Category (CAT_NAME) values ('GROCERIES');
insert into Category (CAT_NAME) values ('ELECTRONICS');
insert into Category (CAT_NAME) values ('CLOTHES');
select*from Category;

insert into Product (PRO_NAME, PRO_DESC, CAT_ID) values 
('GTAV','DFJDJFDJFDJFFDJFJF','2');
insert into Product (PRO_NAME, PRO_DESC, CAT_ID) values 
('TSHIRT','DFDFJDFJDKFD','5'),
('ROG LAPTOP','DFNTTNTNTERND','4'),
('OATS','REURENTBTOTH','3'),
('HARRY POTTER','NBEMCTHTJTH','1');
select*from Product;

insert into ProductDetails (PRO_ID, SUPP_ID, PRICE) values 
('1','2','1500'),
('3','5','30000'),
('5','1','3000'),
('2','3','2500'),
('4','1','1000');

select*from ProductDetails;

insert into Orders (ORD_ID, AMOUNT, ORD_DATE, CUST_ID, PROD_ID) values
('20','1500','2021-10-12','3','5'),
('25','30500','2021-09-16','5','2'),
('26','2000','2021-10-05','1','1'),
('30','3500','2021-08-16','4','3'),
('50','2000','2021-10-06','2','1');

select*from Orders;

insert into Rating (CUST_ID, SUPP_ID, RAT_RATSTARS) values
('2','2','4'),
('3','4','3'),
('5','1','5'),
('1','3','2'),
('4','5','4');
select*from Rating;

/*  3)	Display the number of the customer group by their genders 
who have placed any order of amount greater than or equal to Rs.3000.
*/

select CUS_GENDER, count(CUS_NAME) from
(select CUS_NAME, CUS_GENDER from Customer inner join 
(select*from Orders where AMOUNT >=3000) as a on Customer.CUST_ID = a.CUST_ID) as output group by CUS_GENDER;

/*
 4)	Display all the orders along with the product name ordered by a customer having Customer_Id=2.
*/
select Product.PRO_NAME, q.* from Product
inner join Orders as q on q.PROD_ID=Product.PRO_ID where q.CUST_ID = 2;

/*
5)	Display the Supplier details who can supply more than one product.
*/
select * from Supplier
where Supplier.SUPP_ID = (select SUPP_ID from 
(select SUPP_ID, count(SUPP_ID) from ProductDetails group by SUPP_ID having count(SUPP_ID) >1) as S);

/*
6)	Find the category of the product whose order amount is minimum.
*/
Select CAT_NAME from Category where CAT_ID = (select CAT_ID from Product where Product.PRO_ID=(select PROD_ID
from 
(select*from Orders where Amount =(select min(Amount) from Orders)) as min));

/*
7)	Display the Id and Name of the Product ordered after “2021-10-05”.
*/
select PRO_ID, PRO_NAME from Product
inner join
(select*from Orders where ORD_DATE > "2021-10-05") as d on d.PROD_ID=Product.PRO_ID;

/*
8)	Display customer name and gender whose names start or end with character 'A'.
*/
select CUS_NAME, CUS_GENDER from Customer where CUS_NAME like 'A%' or CUS_NAME like '%A';

/*
9)	Create a stored procedure to display the Rating for a Supplier if any along with 
the Verdict on that rating if any like if rating >4 then “Genuine Supplier” 
if rating >2 “Average Supplier” else “Supplier should not be considered”.
*/

drop procedure if exists DisplayVerdict;
delimiter //
create procedure DisplayVerdict(id int)
begin
	select s.SUPP_ID, r.RAT_RATSTARS,
		case 
			when r.RAT_RATSTARS > 4 then "Genuine Supplier"
            when r.RAT_RATSTARS > 2 then "Average Supplier"
            else "Supplier should not be considered"
		end as Verdict
        from supplier s, rating r
        where s.SUPP_ID = r.SUPP_ID AND s.SUPP_ID = id;
end ;
call DisplayVerdict(3);