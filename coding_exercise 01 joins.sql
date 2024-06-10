-- Create the database
CREATE DATABASE MetroTrainSystem;

-- Use the database
USE MetroTrainSystem;

-- Create the route table
CREATE TABLE route (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    route_name VARCHAR(255) NOT NULL
);

-- Create the station table
CREATE TABLE station (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    locality VARCHAR(100),
    is_interchange TINYINT(1),
    INDEX (name)
);

-- Create the station_route table
CREATE TABLE station_route (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    station_id INT(11),
    route_id INT(11),
    position INT(11),
    FOREIGN KEY (station_id) REFERENCES station(id),
    FOREIGN KEY (route_id) REFERENCES route(id),
    INDEX (station_id),
    INDEX (route_id)
);

-- Create the metro_train table
CREATE TABLE metro_train (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    route_id INT(11),
    position INT(11),
    updated_time DATETIME,
    forward TINYINT(1),
    FOREIGN KEY (route_id) REFERENCES route(id),
    INDEX (route_id)
);

-- Create the train_schedule table
CREATE TABLE train_schedule (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    metro_train_id INT(11),
    station_id INT(11),
    scheduled_time DATETIME,
    FOREIGN KEY (metro_train_id) REFERENCES metro_train(id),
    FOREIGN KEY (station_id) REFERENCES station(id),
    INDEX (metro_train_id),
    INDEX (station_id)
);

-- Create the travel_card table
CREATE TABLE travel_card (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    person_name VARCHAR(100),
    contact_number VARCHAR(100),
    balance DOUBLE
);

-- Create the travel_payment table
CREATE TABLE travel_payment (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    travel_card_id INT(11),
    entry_station_id INT(11),
    entry_time DATETIME,
    exit_station_id INT(11),
    exit_time DATETIME,
    amount DOUBLE,
    FOREIGN KEY (travel_card_id) REFERENCES travel_card(id),
    FOREIGN KEY (entry_station_id) REFERENCES station(id),
    FOREIGN KEY (exit_station_id) REFERENCES station(id),
    INDEX (travel_card_id),
    INDEX (entry_station_id),
    INDEX (exit_station_id)
);

-- Create the train_arrival_time table (based on name mentioned)
CREATE TABLE train_arrival_time (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    metro_train_id INT(11),
    station_id INT(11),
    arrival_time DATETIME,
    FOREIGN KEY (metro_train_id) REFERENCES metro_train(id),
    FOREIGN KEY (station_id) REFERENCES station(id),
    INDEX (metro_train_id),
    INDEX (station_id)
);
show tables;

-- Sample data for route
INSERT INTO route (route_name) VALUES
('North East line'),
('Circle line');

-- Sample data for station
INSERT INTO station (name, locality, is_interchange) VALUES
('North East Station 1', 'Locality 1', 0),
('North East Station 2', 'Locality 2', 1),
('Circle Line Station 1', 'Locality 3', 0),
('Circle Line Station 2', 'Locality 4', 1);

-- Sample data for station_route
INSERT INTO station_route (station_id, route_id, position) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 2);

-- Sample data for metro_train
INSERT INTO metro_train (route_id, position, updated_time, forward) VALUES
(1, 1, '2017-12-20 10:00:00', 1),
(2, 1, '2017-12-21 08:00:00', 1);

-- Sample data for train_schedule
INSERT INTO train_schedule (metro_train_id, station_id, scheduled_time) VALUES
(1, 1, '2017-12-20 10:30:00'),
(1, 2, '2017-12-20 11:00:00'),
(2, 3, '2017-12-21 09:00:00'),
(2, 4, '2017-12-21 09:30:00');

-- Sample data for travel_card
INSERT INTO travel_card (person_name, contact_number, balance) VALUES
('ALEX', '+65 95227525', 35.21),
('KENNY', '+65 85227415', 40.50),
('MICHAEL', '+65 62582155', 52.29),
('AARON LEE', '+65 92588226', 43.25),
('GERARD EE', '+65 87892541', 20.00),
('KAM NING', '+65 78245225', 49.25);

-- Sample data for travel_payment
INSERT INTO travel_payment (travel_card_id, entry_station_id, entry_time, exit_station_id, exit_time, amount) VALUES
(1, 1, '2017-12-20 08:00:00', 2, '2017-12-20 08:30:00', 30.00),
(2, 1, '2017-12-20 09:00:00', 2, '2017-12-20 09:30:00', 28.00),
(3, 1, '2017-12-20 10:00:00', 2, '2017-12-20 10:30:00', 35.00),
(4, 3, '2017-12-21 08:00:00', 4, '2017-12-21 08:30:00', 22.00),
(5, 3, '2017-12-21 09:00:00', 4, '2017-12-21 09:30:00', 18.00),
(6, 1, '2017-12-21 09:30:15', 2, '2017-12-21 09:43:15', 45.00);


/*
QUESTION 1
Write a query to display all the train details that belong to the ‘East-West line’. Display the records in ascending order based on the updated_time.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
id, route_id, position, updated_time, forward 
*/
SELECT tc.person_name, tc.contact_number
FROM travel_payment tp
JOIN travel_card tc ON tp.travel_card_id = tc.id
JOIN station s ON tp.exit_station_id = s.id
JOIN station_route sr ON s.id = sr.station_id
JOIN route r ON sr.route_id = r.id
WHERE r.route_name = 'North East line' AND tp.amount > 25
ORDER BY tc.person_name ASC;
/*
QUESTION 2
Write a query to display the station details which belong to the route 'Downtown line'. Display the records in ascending order based on station_name.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
id, name, locality, is_interchange 
*/
SELECT s.name, s.locality
FROM train_schedule ts
JOIN metro_train mt ON ts.metro_train_id = mt.id
JOIN route r ON mt.route_id = r.id
JOIN station s ON ts.station_id = s.id
WHERE DATE(ts.scheduled_time) = '2017-12-21'
AND r.route_name = 'Circle line'
ORDER BY s.name ASC;


/*
QUESTION 3
Write a query to display person name and contact number of all persons who traveled on 2017-12-23. Display the records in ascending order based on the person's name.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
person_name, contact_number
*/
SELECT person_name, contact_number, balance
FROM travel_card
WHERE balance = (SELECT MIN(balance) FROM travel_card)
ORDER BY person_name DESC;


/*
QUESTION 4
Write a query to display all the train details scheduled on '2017-12-21'. Display the records in ascending order based on position.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
id, route_id, position, updated_time, forward 
*/
SELECT person_name, contact_number, balance, tp.entry_time, tp.exit_time
FROM travel_card tc
JOIN travel_payment tp ON tc.id = tp.travel_card_id
WHERE balance = (
    SELECT DISTINCT balance
    FROM travel_card
    ORDER BY balance DESC
    LIMIT 1 OFFSET 1
)
ORDER BY person_name ASC;


/*
QUESTION 5
Write a query to display the metro train id, position, and updated time of all the trains having deviation. Display the records in ascending order based on updated time.
Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
id, position, updated_time
*/

SELECT tc.person_name, tc.contact_number, tc.balance
FROM travel_card tc
JOIN travel_payment tp ON tc.id = tp.travel_card_id
GROUP BY tc.id
HAVING COUNT(tp.id) = (
    SELECT MAX(travel_count) 
    FROM (
        SELECT COUNT(tp.id) AS travel_count
        FROM travel_payment tp
        GROUP BY tp.travel_card_id
    ) AS travel_counts
)
ORDER BY tc.person_name DESC;
