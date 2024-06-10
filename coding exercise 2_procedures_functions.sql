use electricitybillsystem;
DELIMITER $$

CREATE PROCEDURE insertConnection(IN connection_name VARCHAR(100))
BEGIN
    DECLARE new_id INT;
    -- Calculate the new id as count of existing rows + 1
    SELECT COUNT(*) + 1 INTO new_id FROM electricity_connection_type;
    
    -- Insert the new id and connection_name into the table
    INSERT INTO electricity_connection_type (id, connection_name)
    VALUES (new_id, connection_name);
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE insertMeter(IN meter_number VARCHAR(100), IN building_id INT)
BEGIN
    DECLARE new_id INT;
    -- Calculate the new id as count of existing rows + 1
    SELECT COUNT(*) + 1 INTO new_id FROM meter;
    
    -- Insert the new id, meter_number, and building_id into the table
    INSERT INTO meter (id, meter_number, building_id)
    VALUES (new_id, meter_number, building_id);
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE findTotalUnits(IN meter_number VARCHAR(100))
BEGIN
    DECLARE total_units INT;
    -- Calculate the total units for the given meter_number
    SELECT SUM(total_units) INTO total_units
    FROM electricity_reading
    WHERE meter_number = meter_number;

    -- Output the total units
    SELECT total_units;
END $$
DELIMITER ;


DELIMITER $$

CREATE FUNCTION findTotalUnits(meterNumber VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE total_units INT;
    -- Calculate the total units for the given meterNumber
    SELECT SUM(total_units) INTO total_units
    FROM electricity_reading
    WHERE meter_number = meterNumber;
    
    RETURN total_units;
END $$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION findTotalUnits(meterNumber VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE total_units INT;
    -- Calculate the total units for the given meterNumber
    SELECT SUM(total_units) INTO total_units
    FROM electricity_reading
    WHERE meter_number = meterNumber;
    
    RETURN total_units;
END $$

DELIMITER ;



DELIMITER $$

CREATE FUNCTION findCountofBuildingType(connection_name VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE building_type_count INT;
    -- Calculate the count of building types for the given connection_name
    SELECT COUNT(*) INTO building_type_count
    FROM buildings
    WHERE connection_name = connection_name;
    
    RETURN building_type_count;
END $$

DELIMITER ;




