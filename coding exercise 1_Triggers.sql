use metrotrainsystem;
/*
Create a trigger named 'trigger_route_insert' that is triggered whenever a route record is added to the route table. This trigger will insert the route_name and action into the table 'route_log_history' after the insertion of records into the route table. The action name in the affected log table is 'route_log_history' is 'Insert_Route'.
In Solution, write a trigger alone with the given specifications. The creation of route_log_history table and INSERTing a new row will be taken care in the back end.
Hints:
Trigger name: trigger_route_insert
Table name: route_log_history
Field names: route_name, action
Action: 'Insert_Route'
*/
DELIMITER $$
CREATE TRIGGER trigger_route_insert
AFTER INSERT ON route
FOR EACH ROW
BEGIN
    INSERT INTO route_log_history (route_name, action)
    VALUES (NEW.route_name, 'Insert_Route');
END $$

DELIMITER ;
/*
QUESTION 2
Create a trigger named 'trigger_station_bf_update' that is triggered whenever the station table is updated. This trigger will insert the name and action into the table 'station_log_history' before the updation of station details. The action name in the affected log table station_log_history is 'Before_Update_Station'.
In Solution, write a trigger alone with the given specifications. The creation of station_log_history table and updating row will be taken care in the back end.
Hints:
Trigger name: trigger_station_bf_update
Table name: station_log_history
Field names: name, action
Action: 'Before_Update_Station'
*/
DELIMITER $$

CREATE TRIGGER trigger_station_bf_update
BEFORE UPDATE ON station
FOR EACH ROW
BEGIN
    INSERT INTO station_log_history (name, action)
    VALUES (OLD.name, 'Before_Update_Station');
END $$

DELIMITER ;

/*
QUESTION 3
Create a trigger named 'trigger_travel_card_af_update' that is triggered whenever the travel_card table is updated. This trigger will insert the person_name and action into the table 'travel_card_log_history' after the updation of travel card details. The action name in the affected log table travel_card_log_history is 'After_Update_Travel_Card'.
In Solution, write a trigger alone with the given specifications. The creation of travel_card_log_history table and updating a row will be taken care in the back end.
Hints:
Trigger name: trigger_travel_card_af_update
Table name: travel_card_log_history
Field names: person_name, action
Action: 'After_Update_Travel_Card'
*/
DELIMITER $$

CREATE TRIGGER trigger_travel_card_af_update
AFTER UPDATE ON travel_card
FOR EACH ROW
BEGIN
    INSERT INTO travel_card_log_history (person_name, action)
    VALUES (NEW.person_name, 'After_Update_Travel_Card');
END $$
DELIMITER ;
/*
QUESTION 4
Create a trigger named 'trigger_travel_payment_delete' that is triggered whenever a record in the travel_payment table is deleted. This trigger will insert the travel_card_id, amount and action into the table 'travel_payment_log_history' after the deletion of travel_payment details. The action name in the affected log table travel_payment_log_history is 'After_Delete_Travel_Payment'.
In Solution, write a trigger alone with the given specifications. The creation of travel_payment_log_history table and the deleting of a new one will be taken care in the back end.
Hints:
Trigger name: trigger_travel_payment_delete
Table name: travel_payment_log_history
Field names: travel_card_id, amount, action
Action: 'After_Delete_Travel_Payment'
*/
DELIMITER $$
CREATE TRIGGER trigger_travel_payment_delete
AFTER DELETE ON travel_payment
FOR EACH ROW
BEGIN
    INSERT INTO travel_payment_log_history (travel_card_id, amount, action)
    VALUES (OLD.travel_card_id, OLD.amount, 'After_Delete_Travel_Payment');
END $$
DELIMITER ;

