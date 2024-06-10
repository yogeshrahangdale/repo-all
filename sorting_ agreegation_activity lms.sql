use PersonalTrainer;
-- 1 question
SELECT COUNT(*)
FROM Client;

-- 2 question
SELECT COUNT(BirthDate)
FROM Client;

-- 3 QUESTION 
SELECT
	City,
    COUNT(*)
FROM Client
GROUP BY City
ORDER BY COUNT(*) ASC; -- desc

-- 4 QUESTION
SELECT
	InvoiceId,
    SUM(Price * Quantity) InvoiceTotal
FROM InvoiceLineItem
GROUP BY InvoiceId;

SELECT
	InvoiceId,
    SUM(Price * Quantity) InvoiceTotal
FROM InvoiceLineItem
GROUP BY InvoiceId;

-- 5 QUESTION
SELECT
	InvoiceId,
    SUM(Price * Quantity) InvoiceTotal
FROM InvoiceLineItem
GROUP BY InvoiceId
HAVING SUM(Price * Quantity) > 500.0
ORDER BY SUM(Price * Quantity);

-- 6 QUESTION
SELECT
	c.ClientId,
    c.FirstName,
    c.LastName,
    SUM(li.Price * li.Quantity) Total
FROM Client c
INNER JOIN Invoice i ON c.ClientId = i.ClientId
INNER JOIN InvoiceLineItem li ON i.InvoiceId = li.InvoiceId
WHERE i.InvoiceStatus = 2
GROUP BY c.ClientId, c.FirstName, c.LastName
HAVING SUM(li.Price * li.Quantity) > 1000.00
ORDER BY c.LastName, c.FirstName;

-- 7 QUESTION
SELECT
	c.`Name` CategoryName,
    COUNT(e.ExerciseId) ExerciseCount
FROM ExerciseCategory c
INNER JOIN Exercise e ON c.ExerciseCategoryId = e.ExerciseCategoryId
GROUP BY c.ExerciseCategoryId, c.`Name`
ORDER BY COUNT(e.ExerciseId) DESC;

-- 8 QUESTION
SELECT
	e.`Name` ExerciseName,
    MIN(i.Sets) MinSets,
    MAX(i.Sets) MaxSets,
    AVG(i.Sets) AvgSets
FROM Exercise e
INNER JOIN ExerciseInstance i ON e.ExerciseId = i.ExerciseId
GROUP BY e.ExerciseId, e.`Name`
ORDER BY e.`Name`;

-- 9 QUESTION
SELECT
	w.`Name` WorkoutName,
	MIN(c.BirthDate) EarliestBirthDate,
    MAX(c.BirthDate) LatestBirthDate
FROM Workout w
INNER JOIN ClientWorkout cw ON w.WorkoutId = cw.WorkoutId
INNER JOIN Client c ON cw.ClientId = c.ClientId
GROUP BY w.WorkoutId, w.`Name`
ORDER BY w.`Name`;

-- 10 QUESTION
SELECT
	c.ClientId,
    COUNT(cg.GoalId) GoalCount
FROM Client c
LEFT OUTER JOIN ClientGoal cg ON c.ClientId = cg.ClientId
GROUP BY c.ClientId
ORDER BY COUNT(cg.GoalId) ASC;

-- 11 QUESTION
SELECT
	e.`Name` ExerciseName,
    u.`Name` UnitName,
    MIN(uv.Value) MinValue,
    MAX(uv.Value) 'MaxValue'
FROM Exercise e
INNER JOIN ExerciseInstance ei 
	ON e.ExerciseId = ei.ExerciseId
INNER JOIN ExerciseInstanceUnitValue uv 
	ON ei.ExerciseInstanceId = uv.ExerciseInstanceId
INNER JOIN Unit u ON uv.UnitId = u.UnitId
GROUP BY e.ExerciseId, e.`Name`, u.UnitId, u.`Name`
ORDER BY e.`Name`, u.`Name`;

-- 12 QUESTION
SELECT
	c.`Name` CategoryName,
	e.`Name` ExerciseName,
    u.`Name` UnitName,
    MIN(uv.Value) MinValue,
    MAX(uv.Value) 'MaxValue'
FROM Exercise e
INNER JOIN ExerciseInstance ei 
	ON e.ExerciseId = ei.ExerciseId
INNER JOIN ExerciseInstanceUnitValue uv 
	ON ei.ExerciseInstanceId = uv.ExerciseInstanceId
INNER JOIN Unit u 
	ON uv.UnitId = u.UnitId
INNER JOIN ExerciseCategory c 
	ON e.ExerciseCategoryId = c.ExerciseCategoryId
GROUP BY e.ExerciseId, e.`Name`, u.UnitId, u.`Name`, c.`Name`
ORDER BY c.`Name`, e.`Name`, u.`Name`;

-- 13 QUESTION
SELECT
	l.`Name` LevelName,
	MIN(DATEDIFF(CURDATE(), c.BirthDate) / 365) MinAge,
    MAX(DATEDIFF(CURDATE(), c.BirthDate) / 365) MaxAge
FROM Level l
INNER JOIN Workout w ON l.LevelId = w.LevelId
INNER JOIN ClientWorkout cw ON w.WorkoutId = cw.WorkoutId
INNER JOIN Client c ON cw.ClientId = c.ClientId
GROUP BY l.LevelId, l.`Name`;

-- 14 QUESTION
SELECT
	SUBSTRING_INDEX(EmailAddress, '.', -1),
    COUNT(EmailAddress)
FROM Login
GROUP BY SUBSTRING_INDEX(EmailAddress, '.', -1)
ORDER BY COUNT(EmailAddress) DESC;

-- 15 QUESTION
SELECT
	w.`Name` WorkoutName,
    CONCAT(c.FirstName, ' ', c.LastName) ClientName,
    COUNT(cg.GoalId)
FROM Client c
INNER JOIN ClientGoal cg ON c.ClientId = cg.ClientId
INNER JOIN WorkoutGoal wg ON cg.GoalId = wg.GoalId
INNER JOIN Workout w ON wg.WorkoutId = w.WorkoutId
GROUP BY w.WorkoutId, w.`Name`, c.ClientId, c.FirstName, c.LastName
HAVING COUNT(cg.GoalId) > 1
ORDER BY c.LastName, c.FirstName;



