/*
QUESTION 1
Create a trigger named 'trigger_slab_insert' that is triggered whenever a record is added to the slab table. This trigger will insert the from_unit, to_unit, rate and action into the table 'slab_log_history' after the insertion of records into the slab table. The action name in the affected log table is 'slab_log_history' is "Insert_Slab".
In Solution, write a trigger alone with the given specifications. The creation of slab_log_history table and INSERTing a new row will be taken care in the back end.
Hints:
Trigger name: trigger_slab_insert
Table name: slab_log_history
Field names: from_unit, to_unit, rate, action
Action: 'Insert_Slab'
*/
-- ANSWER 1
-- Header
CREATE TABLE slab_log_history
(id int,
 from_unit int,
 to_unit int,
 rate double,
 action VARCHAR(50));
DELIMITER $$

create trigger trigger_slab_insert
before insert on slab for each row 

begin

insert into slab_log_history(from_unit,to_unit,rate,action) 
values(new.from_unit, new.to_unit, new.rate,'Insert_Slab');

END$$

-- Footer
INSERT INTO slab
VALUES
(5,2,26000, 50000, 40);

SELECT from_unit, to_unit, rate, action FROM slab_log_history;

/*
QUESTION 2
Create a trigger named 'trigger_electricity_connection_type_insert' that is triggered whenever an electricity connection type record is added in the electricity_connection_type table. This trigger will insert the connection_name and action into the table 'electricity_connection_type_log_history' after the insertion of records into the electricity_connection_type table. The action name in the affected log table is 'electricity_connection_type_log_history' is "Insert_Electricity_Connection_Type".
In Solution, write a trigger alone with the given specifications. The creation of electricity_connection_type_log_history table and INSERTing new row will be taken care in the back end.
Hints:
Trigger name: trigger_electricity_connection_type_insert
Table name: electricity_connection_type_log_history
Field names: connection_name, action
Action: 'Insert_Electricity_Connection_Type'
*/
-- ANSWER
-- Hea-der


CREATE TABLE electricity_connection_type_log_history
(id int,
connection_name VARCHAR(100),
action VARCHAR(50));
DELIMITER $$

create trigger trigger_electricity_connection_type_insert
after insert on electricity_connection_type for each row 

begin

insert into electricity_connection_type_log_history(connection_name,action) 
values(new.connection_name,'Insert_Electricity_Connection_Type');
END$$
DELIMITER ;
-- Footer
INSERT INTO electricity_connection_type
VALUES
(3, 'Industrial');

SELECT connection_name, action FROM electricity_connection_type_log_history;
/*
QUESTION 3
Create a trigger named 'trigger_building_bf_update' that is triggered whenever the building table is updated. This trigger will insert the contact_number and action into the table 'building_log_history' before the updation of building details. The action name in the affected log table building_log_history is 'Before_Update_Building'.
In Solution, write a trigger alone with the given specifications. The creation of building_log_history table and updating a row will be taken care in the back end
Hints:
Trigger name: trigger_building_bf_update
Table name: building_log_history
Field names: contact_number, action
Action: 'Before_Update_Building'
*/
-- ANSWER 3
-- Header
CREATE TABLE building_log_history
(id int,
contact_number VARCHAR(100),
action VARCHAR(50));
DELIMITER $$

create trigger trigger_building_bf_update before update 
on building
for each row

begin

insert into building_log_history
set contact_number= old.contact_number,
action='Before_Update_Building';


END$$

DELIMITER ;

-- Footer
UPDATE building
SET contact_number = '+65 12345667'
WHERE id = 4;

SELECT contact_number, action FROM building_log_history;
/*
QUESTION 4
Create a trigger named 'trigger_meter_af_update' that is triggered whenever the meter table is updated. This trigger will insert the meter_number and action into the table 'meter_log_history' after the updation of meter details. The action name in the affected log table meter_log_history is 'After_Update_Meter'.
In Solution, write a trigger alone with the given specifications. The creation of meter_log_history table and updating row will be taken care in the back end. end.
Hints:
Trigger name: trigger_meter_af_update
Table name: meter_log_history
Field names: meter_number, action
Action: 'After_Update_Meter'
*/
-- ANSWER 4
-- Header
CREATE TABLE meter_log_history
(id int,
meter_number VARCHAR(100),
action VARCHAR(50));
DELIMITER $$

create trigger trigger_meter_af_update after update 
on meter
for each row

begin

insert into meter_log_history 
set meter_number= new.meter_number,
action='After_Update_Meter';


END$$

DELIMITER ;

-- Footer
UPDATE meter
SET meter_number = 'SG111111'
WHERE id = 10;

SELECT meter_number, action FROM meter_log_history;

/*
QUESTION 5
Create a trigger named 'trigger_building_type_bf_update' that is triggered whenever the building_type table is updated. This trigger will insert the name and action into the table 'building_update_log_history' before the updation of building type details. The action name in the affected log table building_update_log_history is 'Before_Update_Building_Type'.
In Solution, write a trigger alone with the given specifications. The creation of building_update_log_history table and updating row will be taken care in the back end.
Hints:
Trigger name: trigger_building_type_bf_update
Table name: building_update_log_history
Field names: name, action
Action: 'Before_Update_Building_Type'
*/
-- ANSWER 5
-- Header


CREATE TABLE building_update_log_history
(id int,
name VARCHAR(100),
action VARCHAR(50));
DELIMITER $$

create trigger trigger_building_type_bf_update before update 
on building_type
for each row

begin

insert into building_update_log_history
set name= old.name,
action='Before_Update_Building_Type';
END$$

DELIMITER ;

-- Footer
UPDATE building_type
SET name = 'MULTIPLEX'
WHERE id = 4;

SELECT name, action FROM building_update_log_history;