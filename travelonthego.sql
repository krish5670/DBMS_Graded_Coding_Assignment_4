show databases;
create database if not exists travel_on_the_go;
use travel_on_the_go;
create table if not exists Passenger(

PASSENGER_NAME varchar (50), 
PASSENGER_CATEGOTY varchar (50), 
PASSENGER_GENDER varchar (50),
BOARDING_CITY varchar (50),
DESTINATION_CITY varchar(50),
DISTANCE int,
BUS_TYPE varchar(20));

desc Passenger;
create table Price (
BUS_TYPE varchar(20), 
DISTANCE int,
PRICE int);
desc Price;
insert into Passenger values
	('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper'),
    ('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting'),
    ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper'),
    ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper'),
    ('Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper'),
    ('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting'),
    ('Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper'),
    ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting'),
    ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

insert into Price values
	('Sleeper', 350, 770),
    ('Sleeper', 500, 1100),
    ('Sleeper', 600, 1320),
    ('Sleeper', 700, 1540),
    ('Sleeper', 1000, 2200),
    ('Sleeper', 1200, 2640),
    ('Sleeper', 1500, 2700),
    ('Sitting', 500, 620),
    ('Sitting', 600, 744),
    ('Sitting', 700, 868),
    ('Sitting', 1000, 1240),
    ('Sitting', 1200, 1488),
    ('Sitting', 1500, 1860);

/*
How many females and how many male passengers travelled for a minimum distance of
600 KM s?
*/

select 
Passenger.PASSENGER_GENDER, count(Passenger.PASSENGER_GENDER)
from 
Passenger
where 
Passenger.DISTANCE >=600 
group by 
Passenger.PASSENGER_GENDER;

/*
4) Find the minimum ticket price for Sleeper Bus. 
*/
select
min(Price.Price)
from
Price
where 
Price.BUS_TYPE='Sleeper';

/*
5) Select passenger names whose names start with character 'S'
*/
select PASSENGER_NAME from Passenger where PASSENGER_NAME like 'S%';

/*
6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output

*/

select 
Passenger.PASSENGER_NAME, Passenger.BOARDING_CITY, Passenger.DESTINATION_CITY, Passenger.BUS_TYPE, Price.PRICE 
from 
Passenger,Price
where 
Passenger.BUS_TYPE = Price.BUS_TYPE
AND 
Passenger.DISTANCE = Price.DISTANCE;

/*
7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s 
*/
select 
Passenger.PASSENGER_NAME, Price.PRICE 
from 
Passenger, Price
where 
Passenger.BUS_TYPE = Price.BUS_TYPE
AND 
Passenger.DISTANCE = Price.DISTANCE
AND
Passenger.BUS_TYPE = 'Sitting'
AND
Passenger.DISTANCE = '1000';

/*
8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?
*/
select 
Price.BUS_TYPE, Price.PRICE 
from 
Price 
where 
Price.DISTANCE =( 
select Passenger.DISTANCE from Passenger 
where
Passenger.PASSENGER_NAME = 'Pallavi');

/*
9) List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order
*/
select distinct 
Passenger.DISTANCE 
from 
Passenger 
order by 
Passenger.DISTANCE desc;


/*
10) Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables 
*/
select 
Passenger.PASSENGER_NAME,(Passenger.DISTANCE / Passenger_DISTANCE_sum.total_DISTANCE)*100 distance_percentage 
from 
Passenger,
(select sum(Passenger.DISTANCE) total_DISTANCE 
from 
Passenger) Passenger_DISTANCE_sum;

/*
11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
*/
select 
Price.DISTANCE, Price.PRICE,
CASE 
	When Price.PRICE >=1000 Then 'Expensive'
    When Price.PRICE >=500 Then 'Average Cost'
    Else 'Cheap Price'
    END Price_category
from 
Price; 