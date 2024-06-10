-- Question 1
SELECT 
    id, 
    owner_name, 
    address, 
    building_type_id, 
    contact_number, 
    email_address 
FROM 
    buildings 
WHERE 
    building_type_id = (SELECT id FROM building_types WHERE name = 'Library')
ORDER BY 
    owner_name ASC;

-- Question 2
SELECT 
    contact_number 
FROM 
    buildings 
WHERE 
    building_type_id = (SELECT id FROM building_types WHERE name = 'Police Station')
ORDER BY 
    contact_number ASC;

-- Question 3
SELECT 
    bt.name 
FROM 
    meters m 
JOIN 
    buildings b ON m.building_id = b.id 
JOIN 
    building_types bt ON b.building_type_id = bt.id 
WHERE 
    m.meter_number = 'SG824012';

-- Question 4
SELECT 
    total_units, 
    payable_amount 
FROM 
    meter_readings 
WHERE 
    meter_number = 'SG934826';

-- Question 5
SELECT 
    COUNT(DISTINCT building_id) AS building_count 
FROM 
    fines 
WHERE 
    amount > 0;
