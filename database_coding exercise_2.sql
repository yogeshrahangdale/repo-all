-- Create database
CREATE DATABASE IF NOT EXISTS ElectricityBillSystem;

-- Use the created database
USE ElectricityBillSystem;

-- Create electricity_connection_type table
CREATE TABLE IF NOT EXISTS electricity_connection_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    connection_name VARCHAR(20)
);

-- Create slab table
CREATE TABLE IF NOT EXISTS slab (
    id INT AUTO_INCREMENT PRIMARY KEY,
    connection_type_id INT,
    from_unit INT,
    to_unit INT,
    rate DOUBLE,
    FOREIGN KEY (connection_type_id) REFERENCES electricity_connection_type(id)
);

-- Create electricity_reading table
CREATE TABLE IF NOT EXISTS electricity_reading (
    id INT AUTO_INCREMENT PRIMARY KEY,
    meter_id INT,
    day DATE,
    h1 INT, h2 INT, h3 INT, h4 INT, h5 INT, h6 INT, h7 INT, h8 INT,
    h9 INT, h10 INT, h11 INT, h12 INT, h13 INT, h14 INT, h15 INT,
    h16 INT, h17 INT, h18 INT, h19 INT, h20 INT, h21 INT,
    h22 INT, h23 INT, h24 INT,
    total_units INT,
    FOREIGN KEY (meter_id) REFERENCES meter(id)
);

-- Create building_type table
CREATE TABLE IF NOT EXISTS building_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    connection_type_id INT,
    FOREIGN KEY (connection_type_id) REFERENCES electricity_connection_type(id)
);

-- Create building table
CREATE TABLE IF NOT EXISTS building (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_name VARCHAR(100),
    address VARCHAR(100),
    building_type_id INT,
    contact_number VARCHAR(100),
    email_address VARCHAR(100),
    FOREIGN KEY (building_type_id) REFERENCES building_type(id)
);

-- Create meter table
CREATE TABLE IF NOT EXISTS meter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    meter_number VARCHAR(100),
    building_id INT,
    FOREIGN KEY (building_id) REFERENCES building(id)
);

-- Create bill table
CREATE TABLE IF NOT EXISTS bill (
    id INT AUTO_INCREMENT PRIMARY KEY,
    meter_id INT,
    month INT,
    year INT,
    due_date DATE,
    total_units INT,
    payable_amount DOUBLE,
    payed TINYINT(1),
    payment_date DATE,
    fine_amount DOUBLE,
    FOREIGN KEY (meter_id) REFERENCES meter(id)
);

-- Insert data into electricity_connection_type table
INSERT INTO electricity_connection_type (id, connection_name) VALUES
(1, 'Residential'),
(2, 'Commercial'),
(3, 'Industrial');

-- Insert data into building_type table
INSERT INTO building_type (id, name, connection_type_id) VALUES
(1, 'Residential', 1),
(2, 'Commercial', 2),
(3, 'Industrial', 3),
(4, 'Library', 2),
(5, 'Police Station', 2),
(6, 'Museum', 2);

-- Insert data into building table
INSERT INTO building (id, owner_name, address, building_type_id, contact_number, email_address) VALUES
(27, 'DANNY YONG', 'NATIONAL LIBRARY, 100 VICTORIA ST, SINGAPORE 188064', 4, '+65 6332 3255', 'REF@NB.COM.SG'),
(28, 'SAURABH MITTAL', 'JURONG REGIONAL LIBRARY, 21 JURONG EAST CENTRAL 1, SINGAPORE 609732', 4, '+65 6332 3255', 'REF@NB.COM.SG'),
(29, 'JOHN DOE', 'CENTRAL POLICE STATION, 30 BEDOK RD, SINGAPORE 469061', 5, '+65 1800 255 0000', 'JOHN.DOE@POLICE.SG'),
(30, 'JANE SMITH', 'JURONG POLICE STATION, 25 JURONG WEST AVE 1, SINGAPORE 648160', 5, '+65 1800 363 9999', 'JANE.SMITH@POLICE.SG'),
(31, 'ALICE WONG', 'NATIONAL MUSEUM, 93 STAMFORD RD, SINGAPORE 178897', 6, '+65 6332 5643', 'ALICE.WONG@MUSEUM.SG');

-- Insert data into meter table
INSERT INTO meter (id, meter_number, building_id) VALUES
(1, 'SG824012', 31),
(2, 'SG934826', 29);

-- Insert data into bill table
INSERT INTO bill (id, meter_id, month, year, due_date, total_units, payable_amount, payed, payment_date, fine_amount) VALUES
(1, 2, 5, 2024, '2024-06-05', 19900, 696500, 0, NULL, 50),
(2, 1, 5, 2024, '2024-06-05', 5000, 200000, 1, '2024-06-01', 0),
(3, 2, 4, 2024, '2024-05-05', 15000, 450000, 1, '2024-05-01', 0);
