# Music Competition

[![Database](https://img.shields.io/badge/database-MySQL-green.svg)](https://www.mysql.com/)

The objective of this assignment is to apply your understanding of SQL syntax and programming on a practical database application and to apply your understanding of relational algebra and database design theory.

Assignment from ENSF 608 Fall 2023 - narrative and query prompts created by Dr. Marasco, queries, relational algebra expressions were completed by Jenn Bushey in November 2023.

## Question Narrative

The directors of an annual music competition have decided to organize their participants using a
database.

The competitors must be at least 5 years old and may be no older than 18. They are registered by their
teacher, and all teachers belong to a studio. Guardian information is stored for each participant.

Competitors must perform an approved piece of music from the composition catalog. Each composition
has a genre and may only be played for a competition category of the same genre.

Competitors are entered into a competition category. Each competition has an assigned date, time,
genre, and minimum/maximum participation age. Performers earn a score out of 100 for each
composition that they perform in a particular category.

A file called music_competition_database.sql has been provided for your use in this assignment. Execute this
file in MySQL Workbench to build and populate the schema.

## SQL Queries (20 marks)

Create a new .sql script to write your solutions to the questions below. Use comments to provide any
requested written answers.

1.  Write a query to list all student names (first and last) and the name of the music studio that they
    belong to (1 mark).

2.  Write a query to count how many students belong to each music studio group (1 mark).

3.  Write a query to count how many teachers belong to each music studio group (1 mark).

4.  Write a query to list the last name of all teachers who have more than one student registered in
    the competition (1 mark).

5.  Write a query to list all student names (first and last) who are performing in Romantic genre
    category, along with the title of their chosen composition (2 marks).

6.  Students may choose to play any of the compositions from their category’s genre. Not all
    compositions are currently being played in a category, and some compositions are being played
    multiple times by different students. Write a query to list all possible compositions and which
    categories they are currently being performed in (2 marks).

7.  The competition organizers have hired a team to analyze the performance results. The external
    team do not have permission to view all of the data. Create a view called SCORE_ANALYSIS that
    only lists the ages of each competitor and their final performance score (1 mark).

8.  Display the rows of SCORE_ANALYSIS from the highest score to the lowest score (1 mark).

9.  Write a query to find the highest score, the lowest score, and the average score using
    SCORE_ANALYSIS (1 mark).

10. The competition organizers have decided to add copyright information to their list of available
    compositions. Alter the COMPOSITION table to add a new column called Copyright with a
    default value ‘SOCAN’. Display all rows in the updated table (2 marks).

11. Write a query that uses the NOT EXISTS command to select any competitors who do not meet
    the age restrictions for their chosen performance category (2 marks).

12. Alter the COMPETITOR table to add a CHECK constraint that all competitors must be at least 5
    years old and not older than 18 (1 mark).

13. Harmony Inc. has decided to change their company name to Harmony Studio. Change this
    information in the database and display results in the STUDIO table. Under the update
    command, write a comment (#) to explain how this change was updated in all applicable tables (2 marks).

14. Based on the current database state, explain the error message that results from the following deletion statement. Answer using a comment (#) in your .sql file (1 mark).

        DELETE FROM COMPOSITION WHERE Composer = 'Beethoven';

15. All teachers must have a registered certificate number under their current name and studio information. Any changes will require documentation to be submitted to the competition organizers. In your file, use a comment (#) to explain how the following code addresses this issue (1 mark).

        CREATE TRIGGER Certification
        BEFORE UPDATE ON TEACHER FOR EACH ROW
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Proof of certification must be provided to the main
        office.';

## Relational Algebra Queries (18 marks)

Code the following queries using a single relational algebra expression. You do not need to list the data
results of the query.

1. Write a query to retrieve the first and last name of each competitor (1 mark).

2. Write a query to retrieve the first and last name of all competitors under the age of twelve who
   play the oboe (1 mark).

3. Write a query to retrieve all competitor ID numbers and the name of the music studio that they
   belong to (1 mark).

4. Write a query to retrieve the first name and score earned by each competitor (1 mark).
   Code the following queries using a sequence of relational algebra expressions. You do not need to list
   the data results of the query.

5. Write a query to retrieve the titles of all compositions that will be performed during categories
   scheduled for the 1:00 PM timeslot (3 marks).

6. Write a query to retrieve the titles of all compositions that have not been selected by any performers (3 marks).

7. Code the following query as either a sequence or single expression (4 marks), then draw the corresponding query tree (4 marks). You do not need to list the data results of the query.
   Retrieve a list of all score values that were earned by competitors belonging to the “Music Mastery” studio.

_ENSF 608 Fall 2023 – Marasco_

## Technologies Used

-   MySQL
-   Diagrams were created using [Draw.io](https://draw.io/).
