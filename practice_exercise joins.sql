use personaltrainer;
SELECT *
FROM exercise
JOIN exercisecategory ON exercise.ExerciseCategoryId = exercisecategory.ExerciseCategoryId;

SELECT exercisecategory.Name AS Name, exercise.Name AS Name
FROM exercise
JOIN exercisecategory ON exercise.ExerciseCategoryId = exercisecategory.ExerciseCategoryId
WHERE exercisecategory.ParentCategoryId IS NULL;

SELECT exercisecategory.Name AS CategoryName, exercise.Name AS ExerciseName
FROM exercise
JOIN exercisecategory ON exercise.ExerciseCategoryId = exercisecategory.ExerciseCategoryId
WHERE exercisecategory.ParentCategoryId IS NULL;
