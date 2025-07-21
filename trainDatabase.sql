create database IF NOT EXISTS cs336project;
use cs336project;
create table Train(train_id char(4) primary key);
create table TransitLine(
 line_name  varchar(40) primary key,
 origin varchar(50),
 destination varchar(50),
 fare float
 );
create table Station(
 station_id varchar(10) primary key,
 name varchar(100),
 city varchar(100),
 state char(2)
 );
 create table Schedule(
 schedule_id varchar(10),
 line_name varchar(40),
 train char(4),
 departure_datetime datetime,
 arrival_datetime datetime,
 travel_time varchar(30),
 primary key (train, schedule_id)
 );
 create table Stop(
 station_id varchar(10),
 stop_no int,
 -- station_id int, I assume this was was meant to be taken out.
 arrival_datetime datetime,
 departure_datetime datetime,
 fare_each_stop float,
 primary key (station_id, stop_no)
 );
 create table Customer(
 username varchar(50),
 pword varchar(255),
 email varchar(120),
 first_name varchar(60),
 last_name varchar(60),
 primary key (username, pword)
 );
create table  Employee(
 ssn char(11),
 username varchar(50),
 password varchar(255),
 first_name varchar(60),
 last_name varchar(60),
 primary key (ssn)
 );
create table Reservation(
 reservation_no int,
 travdate date,
 total_fare varchar(50),
 passenger varchar(50),
 primary key (reservation_no)
 );
insert into customer
values
	('dynamism', 'lexicalClarity', 'jlong@rutgers.edu', 'Julian', 'Long'),
	('wishful', 'WipeOutHD', 'arhuman@gmail.com', 'Arslan', 'Huey'),
    ('incredibleRed', 'jeeperscreepers', 'faithk@yahoo.com', 'Faith', 'Kojima'),
    ('wrenchforpeace', 'greenpost', 'aviationfan@outlook.com', 'Cyrus', 'Alexander');