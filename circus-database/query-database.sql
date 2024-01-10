# ENSF 608 Final Design Project - Build and Populate Database
# Mehreen Akmal, Jenn Bushey,  Eric Diep, Hao Liu
#SQL QUERIES 
USE CIRCUS;

# 2) Basic Retrieval Query 
	# Retrieve the name and address of the venue's that are accessible by transit.
	SELECT Name, Street, City, Province FROM VENUE WHERE Transit_Accessible = true;

# 3) A retrieval query with ordered results
	# Retrieve the name, city and capacity of all venues from largest to smallest. 
	SELECT Name, City, Capacity FROM VENUE ORDER BY Capacity DESC; 

# 4) A nested retrieval query
	# Retrieve the name, street and city of the venue that has a show in march. 

	SELECT V.Name, V.Street, V.City 
	FROM VENUE AS V 
	WHERE V.VenueID IN (
		SELECT H.VenueID 
		FROM HOSTED_BY AS H
		WHERE MONTH(H.date )= 3);

# 5) A retrieval query using joined tables
	# List all Performers Fname, Lname performing in the show Corteo.

	SELECT P.FName, P.LName
	FROM PERFORMER AS P JOIN `SHOW` AS S ON P.ShowYear = S.Year AND P.ShowName = S.Name
	WHERE S.Name ="Corteo";

# 6) An update operation with any necessary triggers

	# Demonstrate Trigger
	UPDATE VENUE
	SET Capacity = 30
	WHERE VenueID = 'VEN002';

	# Demonstrate successful update 
	UPDATE VENUE
	SET Capacity = 3000
	WHERE VenueID = 'VEN002';

# 7) A deletion operation with any necessary triggers
	DELETE FROM PERFORMER WHERE PerformerID ="PER005";

# 7b) A deletion operation with any necessary triggers
	DELETE FROM EMERGENCY_CONTACTS WHERE PerformerID ="PER010";



