CREATE DATABASE IF NOT EXISTS metro_system;

USE metro_system;

CREATE TABLE IF NOT EXISTS route (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    route_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS station (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    locality VARCHAR(100),
    is_interchange TINYINT(1)
);

CREATE TABLE IF NOT EXISTS station_route (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    station_id INT(11),
    route_id INT(11),
    position INT(11),
    FOREIGN KEY (station_id) REFERENCES station(id),
    FOREIGN KEY (route_id) REFERENCES route(id)
);

CREATE TABLE IF NOT EXISTS metro_train (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    route_id INT(11),
    position INT(11),
    updated_time DATETIME,
    forward TINYINT(1),
    FOREIGN KEY (route_id) REFERENCES route(id)
);

CREATE TABLE IF NOT EXISTS train_schedule (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    metro_train_id INT(11),
    station_id INT(11),
    scheduled_time DATETIME,
    FOREIGN KEY (metro_train_id) REFERENCES metro_train(id),
    FOREIGN KEY (station_id) REFERENCES station(id)
);

CREATE TABLE IF NOT EXISTS travel_card (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    person_name VARCHAR(100),
    contact_number VARCHAR(100),
    balance DOUBLE
);

CREATE TABLE IF NOT EXISTS travel_payment (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    travel_card_id INT(11),
    entry_station_id INT(11),
    entry_time DATETIME,
    exit_station_id INT(11),
    exit_time DATETIME,
    amount DOUBLE,
    FOREIGN KEY (travel_card_id) REFERENCES travel_card(id),
    FOREIGN KEY (entry_station_id) REFERENCES station(id),
    FOREIGN KEY (exit_station_id) REFERENCES station(id)
);

CREATE TABLE IF NOT EXISTS train_arrival_time (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    metro_train_id INT(11),
    station_id INT(11),
    train_schedule_id INT(11),
    actual_time DATETIME,
    deviation INT(11),
    FOREIGN KEY (metro_train_id) REFERENCES metro_train(id),
    FOREIGN KEY (station_id) REFERENCES station(id),
    FOREIGN KEY (train_schedule_id) REFERENCES train_schedule(id)
);
show tables;

INSERT INTO route (route_name) VALUES
('East-West line'),
('Downtown line');

INSERT INTO station (name, locality, is_interchange) VALUES
('Jurong East MRT Station', '10 Jurong East St 12', 0),
('Outram Park MRT Station', '3 Outram Road', 1),
('Bugis MRT Station', '55 North Bridge Road', 1),
('Dhoby Ghaut MRT Station', '60 Orchard Road', 1),
('City Hall MRT Station', '11 North Bridge Road', 1);

INSERT INTO station_route (station_id, route_id, position) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 2),
(5, 2, 3);

INSERT INTO metro_train (route_id, position, updated_time, forward)
VALUES (1, 3, '2017-12-21 09:10:20', 1),
       (1, 1, '2017-12-23 21:15:15', 1);

INSERT INTO train_schedule (metro_train_id, station_id, scheduled_time)
VALUES (1001, 100, '2017-12-21 09:10:00'),
       (1001, 101, '2017-12-21 09:20:00'),
       (1006, 102, '2017-12-23 21:15:00');

INSERT INTO travel_card (person_name, contact_number, balance) VALUES
('Aaron Lee', '+65 92588226', 50.00),
('Bae Yam Keng', '+65 85255255', 30.00);

INSERT INTO travel_card (person_name, contact_number, balance) VALUES
('Aaron Lee', '+65 92588226', 50.00),
('Bae Yam Keng', '+65 85255255', 30.00),
('Kenny', '+65 85227415', 40.00),
('Rissa', '+65 25252552', 60.00),
('S Dhanabalan', '+65 81237452', 35.00);

INSERT INTO travel_payment (travel_card_id, entry_station_id, entry_time, exit_station_id, exit_time, amount) VALUES
(1, 100, '2017-12-23 08:00:00', 105, '2017-12-23 08:20:00', 2.50),
(2, 101, '2017-12-23 09:30:00', 106, '2017-12-23 09:50:00', 3.00),
(3, 102, '2017-12-23 11:00:00', 107, '2017-12-23 11:20:00', 2.75),
(4, 103, '2017-12-23 12:30:00', 108, '2017-12-23 12:50:00', 3.25),
(5, 104, '2017-12-23 14:00:00', 109, '2017-12-23 14:20:00', 2.00);