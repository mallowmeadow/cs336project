CREATE DATABASE IF NOT EXISTS cs336projectdb;
USE cs336projectdb;

CREATE TABLE Station(
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
FOREIGN KEY (origin_id) REFERENCES Station(station_id),
FOREIGN KEY (dest_id) REFERENCES Station(station_id)
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

CREATE TABLE TrainDiscounts(
disc_type VARCHAR(20) PRIMARY KEY,
disc_rate FLOAT NOT NULL 
);

CREATE TABLE Schedule(
id CHAR(4) NOT NULL,
stop_num INT NOT NULL,
station_id CHAR(4) NOT NULL,
arrival_datetime  DATETIME NOT NULL,
departure_datetime DATETIME NOT NULL,
PRIMARY KEY (id, stop_num),
FOREIGN KEY (id) REFERENCES TrainSchedule(trainschedule_id),
FOREIGN KEY (id) REFERENCES Station(station_id)
);

CREATE TABLE Customer(
customer_id CHAR(4) PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
username VARCHAR(50) NOT NULL,
pass VARCHAR(100) NOT NULL
);

CREATE TABLE Employee(
ssn CHAR(9) PRIMARY KEY,
employee_firstname VARCHAR(50) NOT NULL,
employee_lastname VARCHAR(50) NOT NULL,
employee_role VARCHAR(20) NOT NULL,
username VARCHAR(50) NOT NULL,
pass VARCHAR(100) NOT NULL 
);

CREATE TABLE Reservation( 
res_num  INT PRIMARY KEY,
res_date DATETIME NOT NULL,
customer_id CHAR(4) NOT NULL,
id CHAR(4) NOT NULL,
origin_id CHAR(4) NOT NULL,
dest_id CHAR(4)  NOT NULL,
departure_datetime DATETIME NOT NULL,
trip_type VARCHAR(10) NOT NULL, 
total_fare FLOAT NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
FOREIGN KEY (id) REFERENCES TrainSchedule(trainschedule_id),
FOREIGN KEY (origin_id) REFERENCES TransitLine(origin_id),
FOREIGN KEY (dest_id)REFERENCES Station(station_id)
);

CREATE TABLE CustomerQuestions(
ques_id CHAR(4) PRIMARY KEY,
customer_id CHAR(4) NOT NULL,
question TEXT NOT NULL,
question_date DATETIME NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE EmployeeReply(
reply_id CHAR(4) PRIMARY KEY,
ques_id CHAR(4) NOT NULL,
employee_ssn CHAR(9) NOT NULL,
reply TEXT NOT NULL,
reply_date DATETIME NOT NULL,
FOREIGN KEY (ques_id) REFERENCES CustomerQuestions(ques_id),
FOREIGN KEY (employee_ssn) REFERENCES Employee(ssn)
);

INSERT INTO Station(station_id, station_name, city, state) VALUES
('TRNT','Trenton','Trenton','NJ'),
('NYPN','NY Penn Station','New York','NY'),
('PRIN','Princeton','Princeton','NJ'),
('NWBR','New Brunswick','New Brunswick','NJ'),
('EDSN','Edison','Edison','NJ'),
('MTCN','Metuchen','Metuchen','NJ');

INSERT INTO TransitLine(transit_id, transit_name, origin_id, dest_id, fare) VALUES
('NECO', 'Northeast Corridor', 'NYPN', 'TRNT', 50.00);

INSERT INTO Train(train_id, transit_id) VALUES
('3806', 'NECO'),
('2345', 'NECO');

INSERT INTO TrainSchedule(trainschedule_id, transit_id, departure_datetime, arrival_datetime, travel_time, train_fare) VALUES
('T123', 'NECO', '2020-07-22 03:48:00', '2020-07-22 05:21:00', '2020-07-22 01:33:00', 50.00),
('T456', 'NECO', '2020-08-10 11:00:00', '2020-08-10 11:59:00', '2020-08-10 00:59:00', 80.00);

INSERT INTO TrainDiscounts(disc_type, disc_rate) VALUES
('Children (1-11 yrs)', 0.25),
('Senior', 0.35),
('Disabled', 0.50);

INSERT INTO Schedule(id, stop_num, station_id, arrival_datetime, departure_datetime) VALUES
('T123', 1, 'TRNT', '2025-07-22 03:48:00', '2025-07-22 03:48:00'),
('T123', 2, 'PRIN', '2025-07-22 04:10:00', '2025-07-22 04:12:00'),
('T123', 3, 'NWBR', '2025-07-22 04:25:00', '2025-07-22 04:27:00'),
('T123', 4, 'EDIS', '2025-07-22 04:40:00', '2025-07-22 04:42:00'),
('T123', 5, 'METC', '2025-07-22 04:55:00', '2025-07-22 04:57:00'),
('T123', 6, 'NYPN', '2025-07-22 05:21:00', '2025-07-22 05:21:00');

INSERT INTO Schedule(id, stop_num, station_id, arrival_datetime, departure_datetime) VALUES
('T456', 1, 'NWBR', '2020-08-10 11:00:00', '2020-08-10 11:00:00'),
('T456', 2, 'NYPN', '2020-08-10 11:59:00', '2020-08-10 11:59:00');

INSERT INTO Customer(customer_id, first_name, last_name, email, username, pass) VALUES
('0001', 'John', 'Smith', 'john.smith23@gmail.com', 'jsmith23', 'abc123');

INSERT INTO Employee(ssn, employee_firstname, employee_lastname, employee_role, username, pass) VALUES
('123456789','Tom', 'Cruz', 'Manager', 'tcruz24', 'tcruz24'),
('012345678','Kobbie', 'Mainoo', 'Employee', 'MUTD13', 'kman23');

INSERT INTO Reservation(res_num, res_date, customer_id, id, origin_id, dest_id, departure_datetime, trip_type, total_fare) VALUES
(0123, '2020-07-22 00:00:00', '0001', 'T456','NWBR', 'NYPN', '2020-08-10 11:00:00','one-way', 80.00);

INSERT INTO CustomerQuestions(ques_id, customer_id, question, question_date) VALUES
('Q001', '0001', 'How much off do seniors receive?', '2020-07-20 09:15:00');

INSERT INTO EmployeeReply(reply_id, ques_id,  employee_ssn, reply, reply_date) VALUES
('R001', 'Q001', '123456789', 'Seniors receive 35% off','2020-07-20 10:00:00');

/* helper VIEWS for reports*/
CREATE OR REPLACE VIEW SchedulesByStation AS
SELECT ts.*, s.station_id
FROM TrainSchedule ts
JOIN Schedule s        ON ts.trainschedule_id = s.id;

/* customers on a line + date */
CREATE OR REPLACE VIEW CustomersByLineDate AS
SELECT DISTINCT c.*, ts.transit_id, DATE(r.departure_datetime) AS travel_date
FROM Reservation r
JOIN Customer     c  ON r.customer_id = c.customer_id
JOIN TrainSchedule ts ON r.id = ts.trainschedule_id;
