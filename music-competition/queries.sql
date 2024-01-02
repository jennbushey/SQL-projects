/* ENSF 608 Fall 2023
* November 20, 2023
* Jennifer Bushey
*/ 

-- 1. Write a query to list all student names (first and last) and the name of the music studio that they
--  	belong to (1 mark).
SELECT C.FName, C.LName, T.StudioName 
FROM COMPETITOR as C, TEACHER as T 
WHERE C.TeacherID = T.TeacherID;



-- 2. Write a query to count how many students belong to each music studio group (1 mark).
SELECT T.StudioName, COUNT(DISTINCT C.CompetitorID) 
FROM COMPETITOR as C, Teacher as T 
WHERE C.TeacherID = T.TeacherID 
GROUP BY T.StudioName;



-- 3. Write a query to count how many teachers belong to each music studio group (1 mark).
SELECT T.StudioName, COUNT(DISTINCT T.TeacherID) as NumTeachers
FROM Teacher as T 
GROUP BY T.StudioName;



-- 4. Write a query to list the last name of all teachers who have more than one student registered in
-- 	the competition (1 mark).
SELECT T.LName 
FROM Teacher as T, COMPETITOR as C 
WHERE C.TeacherID = T.TeacherID  
GROUP BY T.LName 
HAVING COUNT(C.TeacherID) > 1;



-- 5. Write a query to list all student names (first and last) who are performing in Romantic genre
-- 	category, along with the title of their chosen composition (2 marks).
SELECT C.FName, C.LName, M.Title
FROM COMPETITOR as C, COMPOSITION as M, PERFORMANCE as P 
WHERE P.CompetitorID = C.CompetitorID AND P.MusicID = M.MusicID AND M.Genre = 'Romantic';



-- 6. Students may choose to play any of the compositions from their category’s genre. Not all
-- 	compositions are currently being played in a category, and some compositions are being played
-- 	multiple times by different students. Write a query to list all possible compositions and which
-- 	categories they are currently being performed in (2 marks).
SELECT DISTINCT(M.MusicID), P.CategoryID, G.Genre as CategoryGenre
FROM COMPOSITION as M LEFT OUTER JOIN 
	(PERFORMANCE as P JOIN CATEGORY as G ON P.CategoryID = G.CategoryID) 
	on M.MusicID = P.MusicID;



-- 7. The competition organizers have hired a team to analyze the performance results. The external
-- 	team do not have permission to view all of the data. Create a view called SCORE_ANALYSIS that
-- 	only lists the ages of each competitor and their final performance score (1 mark).
-- DROP VIEW IF EXISTS SCORE_ANALYSIS; 
-- created to delete the intermediate views while I am working on correctly building the view.
CREATE VIEW SCORE_ANALYSIS
AS SELECT C.Age as Age, P.Score as Score
FROM COMPETITOR as C, PERFORMANCE as P
WHERE P.CompetitorID = C.CompetitorID;



-- 8. Display the rows of SCORE_ANALYSIS from the highest score to the lowest score (1 mark).
SELECT *
FROM SCORE_ANALYSIS
ORDER BY Score DESC;



-- 9. Write a query to find the highest score, the lowest score, and the average score using
--    SCORE_ANALYSIS (1 mark).
SELECT MAX(Score), MIN(Score), AVG(Score) 
FROM SCORE_ANALYSIS;



-- 10. The competition organizers have decided to add copyright information to their list of available
--    compositions. Alter the COMPOSITION table to add a new column called Copyright with a
--    default value ‘SOCAN’. Display all rows in the updated table (2 marks).
ALTER TABLE COMPOSITION
ADD Copyright varchar(25)
DEFAULT 'SOCAN';

SELECT *
FROM COMPOSITION;



-- 11. Write a query that uses the NOT EXISTS command to select any competitors who do not meet
--    the age restrictions for their chosen performance category (2 marks).

SELECT C.FName, C.LName
FROM (PERFORMANCE as P JOIN CATEGORY as G ON P.CategoryID = G.CategoryID) JOIN COMPETITOR as C ON C.CompetitorID = P.CompetitorID
WHERE NOT EXISTS( SELECT G.AgeMax, G.AgeMin
                    WHERE C.Age <= G.AgeMax  AND C.Age >= G.AgeMin
                    );
# displays no rows, all competitors meet the age restrictions


-- 12. Alter the COMPETITOR table to add a CHECK constraint that all competitors must be at least 5
--    years old and not older than 18 (1 mark).
ALTER TABLE COMPETITOR
ADD CONSTRAINT CHK_AGE CHECK (Age >= 5 AND Age <= 18);



-- 13. Harmony Inc. has decided to change their company name to Harmony Studio. Change this
--    information in the database and display results in the STUDIO table. Under the update
--    command, write a comment (#) to explain how this change was updated in all applicable tables
--    (2 marks).
UPDATE STUDIO
SET Name = 'Harmony Studio'
WHERE Name = 'Harmony Inc.';
#  Foreign key StudioName in the TEACHER table was created with the ON UPDATE CASCADE option 
#  which means that when we update the parent table (STUDIO) the referencing rows in the child
#  table (TEACHER) are updated as well. 
#  Updating the Name in the STUDIO table updates the corresponding StudioName value in the TEACHER 
#  table because of this option. 
SELECT * FROM STUDIO;




-- 14. Based on the current database state, explain the error message that results from the following
--    deletion statement. Answer using a comment (#) in your .sql file (1 mark).
DELETE FROM COMPOSITION WHERE Composer = 'Beethoven';

#  Error Code: 1175. 
#  You are using safe update mode and you tried to update a table without a 
#  WHERE that uses a KEY column.  To disable safe mode, toggle the option in 
#  Preferences -> SQL Editor and reconnect.

#  Answer: 
#  In safe update mode, MySQL prevents you from executing UPDATE or DELETE statements that don't have 
#  a WHERE clause using a key column. This is a safety feature to prevent accidental updates or 
#  deletions of entire tables.

#  The requirement for using a WHERE clause and key column means that we are forced to explicitly state 
#  which rows are to be deleted which would reduce the chance of accidentally deleting a larger 
#  portion of a dataset. Safemode requires the user to explicitly write out what is to be deleted to
#  protect the integrity of the database.



-- 15. All teachers must have a registered certificate number under their current name and studio
--    information. Any changes will require documentation to be submitted to the competition
--    organizers. In your file, use a comment (#) to explain how the following code addresses this
--    issue (1 mark).

CREATE TRIGGER Certification
BEFORE UPDATE ON TEACHER FOR EACH ROW
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Proof of certification must be provided to the main office.';

#  Answer: 
#  The code creates a trigger that sends a custom error message and will not allow update to the TEACHER 
#  table. The trigger is a rule that is set in motion when update action are perfomed to the table.
#  Before performing the update, (BEFORE UPDATE) the trigger will send the signal 45000. This signal is 
#  an error code that means unhandles user-defined exception.  
#  The signal also has the option of adding a custom message to the error by using the MESSAGE_TEXT option. 
#  The update on the TEACHER table will not occur, and the update action will fail due to the triggered 
#  exception.


