use trackit;

INSERT INTO Worker (WorkerId, FirstName, LastName)
  VALUES (1, 'Rosemonde', 'Featherbie');
insert into Worker (WorkerId, FirstName, LastName)
  VALUES (2, 'Rose', 'Featherbie2');
  INSERT INTO Worker (FirstName, LastName) VALUES
  ('Goldi','Pilipets'),
  ('Dorey','Rulf'),
  ('Panchito','Ashtonhurst');
  
select * from Worker;

INSERT INTO Worker (WorkerId, FirstName, LastName)
  VALUES (6, 'Valentino', 'Newvill');
  
  INSERT INTO Project (ProjectId, `Name`, DueDate)
  VALUES ('db-milestone', 'Database Material', '2018-12-31'); 
  
  INSERT INTO ProjectWorker (ProjectId, WorkerId)
  VALUES ('db-milestone', 75);
  
  INSERT INTO Project (ProjectId, `Name`, DueDate)
VALUES ('kitchen', 'Kitchen Remodel', '2025-07-15'); 

INSERT INTO ProjectWorker (ProjectId, WorkerId) VALUES 
  ('db-milestone', 1), -- Rosemonde, Database
  ('kitchen', 2),      -- Kingsly, Kitchen
  ('db-milestone', 3), -- Goldi, Databaseprojectworker
  ('db-milestone', 4); -- Dorey, Database
  
  SET SQL_SAFE_UPDATES = 0;
  
  -- Provide a Project Summary and change the DueDate.
UPDATE Project SET
  Summary = 'All lessons and exercises for the relational database milestone.',
  DueDate = '2018-10-15'
WHERE ProjectId = 'db-milestone';

-- Change Kingsly's LastName to 'Oaks'.
UPDATE Worker SET
  LastName = 'Oaks'
WHERE WorkerId = 2;
select * from Worker 
where WorkerId=2;

-- Disable safe updates.
SET SQL_SAFE_UPDATES = 0;

-- Deactivate active Projects from 2017.
UPDATE Project SET
  IsActive = 0
WHERE DueDate BETWEEN '2017-01-01' AND '2017-12-31'
AND IsActive = 1;

-- Enable safe updates.
SET SQL_SAFE_UPDATES = 1;
  
  
  