CREATE DATABASE electricity_bill_system;
USE electricity_bill_system;

CREATE TABLE electricity_connection_type (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    connection_name VARCHAR(20),
    INDEX (id)
);

CREATE TABLE slab (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    connection_type_id INT(11),
    from_unit INT(11),
    to_unit INT(11),
    rate DOUBLE,
    INDEX (id),
    INDEX (connection_type_id),
    FOREIGN KEY (connection_type_id) REFERENCES electricity_connection_type(id)
);
CREATE TABLE electricity_reading (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    meter_id INT(11),
    day DATE,
    h1 INT(11),
    h2 INT(11),
    h3 INT(11),
    h4 INT(11),
    h5 INT(11),
    h6 INT(11),
    h7 INT(11),
    h8 INT(11),
    h9 INT(11),
    h10 INT(11),
    h11 INT(11),
    h12 INT(11),
    h13 INT(11),
    h14 INT(11),
    h15 INT(11),
    h16 INT(11),
    h17 INT(11),
    h18 INT(11),
    h19 INT(11),
    h20 INT(11),
    h21 INT(11),
    `122` INT(11),
    `123` INT(11),
    `1124` INT(11),
    total_units INT(11),
    INDEX (id),
    INDEX (meter_id)
);

CREATE TABLE building_type (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    connection_type_id INT(11),
    INDEX (id),
    INDEX (connection_type_id),
    FOREIGN KEY (connection_type_id) REFERENCES electricity_connection_type(id)
);

CREATE TABLE building (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    owner_name VARCHAR(100),
    address VARCHAR(100),
    building_type_id INT(11),
    contact_number VARCHAR(100),
    email_address VARCHAR(100),
    INDEX (id),
    INDEX (building_type_id),
    FOREIGN KEY (building_type_id) REFERENCES building_type(id)
);

CREATE TABLE meter (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    meter_number VARCHAR(100),
    building_id INT(11),
    INDEX (id),
    INDEX (building_id),
    FOREIGN KEY (building_id) REFERENCES building(id)
);

CREATE TABLE bill (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    meter_id INT(11),
    month INT(11),
    year INT(11),
    due_date DATE,
    total_units INT(11),
    payable_amount DOUBLE,
    payed TINYINT(1),
    payment_date DATE,
    fine_amount DOUBLE,
    INDEX (id),
    INDEX (meter_id),
    FOREIGN KEY (meter_id) REFERENCES meter(id)
);

-- insertinon of data in tables
-- Insert sample data into electricity_connection_type
INSERT INTO electricity_connection_type (connection_name) VALUES 
('Residential'), 
('Commercial'), 
('Industrial');

-- Insert sample data into slab
INSERT INTO slab (connection_type_id, from_unit, to_unit, rate) VALUES 
(1, 0, 100, 1.50), 
(1, 101, 200, 2.00), 
(2, 0, 100, 2.50), 
(2, 101, 200, 3.00), 
(3, 0, 100, 3.50), 
(3, 101, 200, 4.00);

-- Insert sample data into building_type
INSERT INTO building_type (name, connection_type_id) VALUES 
('Apartment', 1), 
('Shop', 2), 
('Factory', 3);

-- Insert sample data into building
INSERT INTO building (owner_name, address, building_type_id, contact_number, email_address) VALUES 
('HAIDIL', 'VIVOCITY, 1 HARBOURFRONT WALK, SINGAPORE 098585', 1, '+65 6377 6860', 'VIVOSUPPORT@VIVOCITY.COM.SG'), 
('MUHAMMAD HAFAZ', 'SUNTEC CITY, 3E TEMASEK BOULEVARD, SINGAPORE 038984', 1, '+65 6266 1502', 'SUNTECENQUIRIES@SUNTECREIT.SG'),
('PEISEN', 'V HOTEL LAVENDER, 70 JELLICOE RD, SINGAPORE 208767', 2, '+65 6345 2233', 'CONTACTLAVENDER@VHOTEL.SG'),
('CLAUDIA MOONSOON', 'STRAND HOTEL SINGAPORE, 25 BENCOOLEN ST, SINGAPORE CITY 189619', 2, '+65 6338 1866', 'RESERVESTRAND@STRANDHOTEL.COM.SG'),
('MUZZAMMIL', 'OCBC ARENA, 5 STADIUM DRIVE, SINGAPORE 397631', 3, '+65 6653 8900', 'MAIL@THEKALLANGWAVE.SG');

-- Insert sample data into meter
INSERT INTO meter (meter_number, building_id) VALUES 
('SG934826', 1), 
('SG923564', 2);

-- Insert sample data into electricity_reading
INSERT INTO electricity_reading (meter_id, day, h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13, h14, h15, h16, h17, h18, h19, h20, h21, `122`, `123`, `1124`, total_units) VALUES 
(1, '2018-05-06', 5, 5, 5, 5, 5, 5, 5, 5, 5, 50, 55, 50, 60, 60, 50, 50, 55, 50, 50, 80, 75, 75, 5, 5, 815), 
(2, '2018-05-07', 5, 5, 5, 5, 5, 5, 5, 5, 5, 45, 45, 50, 55, 50, 50, 55, 60, 60, 55, 75, 80, 70, 5, 5, 805);

-- Insert sample data into bill
INSERT INTO bill (meter_id, month, year, due_date, total_units, payable_amount, payed, payment_date, fine_amount) VALUES 
(1, 5, 2018, '2018-05-30', 815, 696500, 1, '2018-05-20', 0), 
(2, 5, 2018, '2018-05-30', 805, 595000, 0, NULL, 10000);


/* QUESTION 1
Create a view named 'building_details' to display all the details of the building.
Input Format
The input tables are populated in the backend. 
Output Format
The output will have the below header if the view is created successfully.
id, owner_name, address, building_type_id, contact_number, email_address  */
CREATE VIEW building_details AS
SELECT * FROM building;
SELECT * FROM building_details;
/*
QUESTION 2
Create a view named 'building_owners' to display all the owners of the building.
Input Format
The input tables are populated in the backend. 
Output Format
The output will have the below header if the view is created successfully.
owner_name
*/
CREATE VIEW building_owners AS
SELECT owner_name FROM building;
SELECT * FROM building_owners;
/*
QUESTION 3
Create a view named 'owner_details' to display the owner name and contact number of the buildings having length of the owner name greater than 15.
Input Format
The input tables are populated in the backend. 
Output Format
The output will have the below header if the view is created successfully.
owner_name, contact_number
*/
CREATE VIEW owner_details AS
SELECT owner_name, contact_number
FROM building
WHERE length(owner_name) > 15;
SELECT * FROM owner_details;
/*QUESTION 4
Create a view named 'electricity_reading_details' to display all the details of the electricity having total units per day greater than 500 units.
Input Format
The input tables are populated in the backend. 
Output Format
The Output header will have all the columns from electricity_reading table.
*/
CREATE VIEW electricity_reading_details AS
SELECT * FROM electricity_reading
WHERE total_units > 500;
-- Footer
SELECT * FROM electricity_reading_details;
/*
QUESTION 5
Create a view named 'all_payable_amount' to display the meter number and its corresponding payable amount in the bill.
Input Format
The input tables are populated in the backend. 
Output Format
The output will have the below header if the view is created successfully.
meter_number, payable_amount
*/
CREATE VIEW all_payable_amount AS
SELECT A.meter_number, B.payable_amount
FROM 
meter A JOIN bill B ON A.id = B.meter_id;
-- Footer
SELECT * FROM all_payable_amount;