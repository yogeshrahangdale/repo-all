-- Question 1
SELECT 
    id, 
    route_id, 
    position, 
    updated_time, 
    forward 
FROM 
    trains 
WHERE 
    route_name = 'East-West line' 
ORDER BY 
    updated_time ASC;

-- Question2
SELECT 
    id, 
    name, 
    locality, 
    is_interchange 
FROM 
    stations 
WHERE 
    route_name = 'Downtown line' 
ORDER BY 
    name ASC;

-- QUestion3
SELECT 
    p.name AS person_name, 
    p.contact_number 
FROM 
    travels t 
JOIN 
    persons p 
ON 
    t.person_id = p.id 
WHERE 
    t.travel_date = '2017-12-23' 
ORDER BY 
    p.name ASC;

-- Question 4

SELECT 
    id, 
    route_id, 
    position, 
    updated_time, 
    forward 
FROM 
    train_schedule 
WHERE 
    DATE(updated_time) = '2017-12-21' 
ORDER BY 
    position ASC;


-- Question 5

SELECT 
    id, 
    position, 
    updated_time 
FROM 
    train_schedule 
WHERE 
    deviation = 1 
ORDER BY 
    updated_time ASC;
