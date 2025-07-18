CREATE TABLE Stations(
 station_id CHAR(4) PRIMARY KEY,
 station_name VARCHAR(50) NOT NULL,
 city  VARCHAR(50) NOT NULL,
 state CHAR(2) NOT NULL
);

CREATE TABLE TransitLine(
transit_id CHAR(4) PRIMARY KEY,
transit_name VARCHAR(50) NOT NULL,
origin_id CHAR(4) NOT NULL,
dest_id CHAR(4) NOT NULL,
fare FLOAT NOT NULL,
FOREIGN KEY (origin_id) REFERENCES Stations(station_id),
FOREIGN KEY (dest_id) REFERENCES Stations(station_id)
);

CREATE TABLE Train(
train_id CHAR(4) PRIMARY KEY,
transit_id CHAR(4) NOT NULL,
FOREIGN KEY (transit_id) REFERENCES TransitLine(transit_id)
);

CREATE TABLE TrainSchedule(
trainschedule_id CHAR(4),
transit_id CHAR(4) NOT NULL,
departure_datetime DATETIME NOT NULL,
arrival_datetime DATETIME NOT NULL,
travel_time DATETIME NOT NULL,
train_fare FLOAT NOT NULL,
FOREIGN KEY (transit_id) REFERENCES TransitLine(transit_id)
);

CREATE TABLE TrainDiscounts (
disc_type VARCHAR(20) PRIMARY KEY,
disc_rate FLOAT NOT NULL 
);

CREATE TABLE Schedules(
id CHAR(4) NOT NULL,
stop_num INT NOT NULL,
station_id CHAR(4) NOT NULL,
arrival_datetime  DATETIME NOT NULL,
departure_datetime DATETIME NOT NULL,
PRIMARY KEY (id, stop_num),
FOREIGN KEY (id) REFERENCES TrainSchedule(trainschedule_id),
FOREIGN KEY (id)  REFERENCES Stations(station_id)
);

CREATE TABLE Customers(
customer_id CHAR(4) PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
username VARCHAR(50) NOT NULL,
pass VARCHAR(100) NOT NULL
);

CREATE TABLE Employees(
ssn CHAR(9) PRIMARY KEY,
employee_firstname VARCHAR(50) NOT NULL,
employee_lastname VARCHAR(50) NOT NULL,
employee_role VARCHAR(20) NOT NULL,
username VARCHAR(50) NOT NULL,
pass VARCHAR(100) NOT NULL 
);

CREATE TABLE Reservations( 
res_num  INT PRIMARY KEY,
res_date DATETIME NOT NULL,
customer_id CHAR(4) NOT NULL,
id CHAR(4) NOT NULL,
origin_id CHAR(4) NOT NULL,
dest_id CHAR(4)  NOT NULL,
departure_datetime DATETIME NOT NULL,
trip_type VARCHAR(10) NOT NULL, 
total_fare FLOAT NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
FOREIGN KEY (id) REFERENCES TrainSchedule(id),
FOREIGN KEY (origin_id) REFERENCES Stations(origin_id),
FOREIGN KEY (dest_id)REFERENCES Stations(station_id)
);

CREATE TABLE CustomerQuestions (
ques_id CHAR(4) PRIMARY KEY,
customer_id CHAR(4) NOT NULL,
question TEXT NOT NULL,
question_date DATETIME NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE EmployeeReply (
reply_id CHAR(4) PRIMARY KEY,
ques_id CHAR(4) NOT NULL,
employee_ssn CHAR(9) NOT NULL,
reply TEXT NOT NULL,
reply_date DATETIME NOT NULL,
FOREIGN KEY (ques_id) REFERENCES CustomerQuestions(ques_id),
FOREIGN KEY (employee_ssn) REFERENCES Employees(ssn)
);