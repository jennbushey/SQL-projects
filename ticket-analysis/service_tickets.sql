DROP DATABASE IF EXISTS SERVICE_TICKETS;
CREATE DATABASE SERVICE_TICKETS;
USE SERVICE_TICKETS;

-- Create Event Activity Table
DROP TABLE IF EXISTS EventActivity;
CREATE TABLE EventActivity (
  ID int NOT NULL AUTO_INCREMENT COMMENT 'Primary key of activity. Should auto increment.',
  ActivityName VARCHAR(20) COMMENT 'Activity name.',
  PRIMARY KEY (ID)    
);
	-- Populate Event Activity with possible entries
	INSERT INTO EventActivity (ActivityName) values ('Design'),('Construction'),('Test'),('Password Reset'); 

-- Create Event Origin Table
DROP TABLE IF EXISTS EventOrigin;
CREATE TABLE EventOrigin (
  ID int NOT NULL AUTO_INCREMENT COMMENT 'Primary key of activity. Should auto increment.',
  OriginName VARCHAR(20) COMMENT 'Name of originator.',
  PRIMARY KEY (ID)
  );
	-- Populate Event Origin with possible entries
	INSERT INTO EventOrigin (OriginName) values('Joe S.'), ('Bill B.'), ('George E.'),('Achmed M.'), ('Rona E.');
  
-- Create Event Status Table
DROP TABLE IF EXISTS EventStatus;
CREATE TABLE EventStatus (
  ID int NOT NULL AUTO_INCREMENT COMMENT 'Primary key of activity. Should auto increment.',
  Status VARCHAR(20) COMMENT 'Status description.',
  PRIMARY KEY (ID)
  );
	-- Populate Event Status with possible entries
	INSERT INTO EventStatus (Status) values('Open'),('On Hold'),('In Process'), ('Deployed'), ('Deployed Failed');
  
-- Create Event Class Table
DROP TABLE IF EXISTS EventClass;
CREATE TABLE EventClass (
  ID int NOT NULL AUTO_INCREMENT COMMENT 'Primary key of activity. Should auto increment.',
  Class VARCHAR(20) COMMENT 'Class description',
  PRIMARY KEY (ID)
  );
	-- Populate Event Class with possible entries
	INSERT INTO EventClass (Class) values('Change'),('Incident'),('Problem'),('SR');


DROP TABLE IF EXISTS EventLog;
CREATE TABLE EventLog (
  ID INTEGER NOT NULL auto_increment, -- auto populate id
  Caseid VARCHAR(20),
  Activity varchar(20),
  Urgency varchar(1),
  Impact varchar(1),
  Priority varchar(1) AS (Urgency + Impact - 1),  -- calculate priority based on urgency and impact
  StartDate date,
  EndDate date,
  TicketStatus varchar(20),
  UpdateDateTime datetime not null default(current_timestamp), -- automatically applies datestamp
  Duration Integer,
  Origin varchar(20),
  Class varchar(20),
  
  PRIMARY KEY (ID),
  
  CONSTRAINT unique_CaseID UNIQUE (Caseid), -- Unique Case Id
  CONSTRAINT chk_caseid CHECK (Caseid Like 'CS_%'), -- Case ID must start with CS_
  CONSTRAINT chk_Urgency CHECK (Urgency IN ('1', '2', '3')),   -- Urgency Values must equal 1, 2, or 3
  CONSTRAINT chk_Impact CHECK (Impact IN ('1', '2', '3')), -- Impact Values must equal 1, 2, or 3
  CONSTRAINT chk_Duration CHECK (Duration > 0)
  );

-- Create specific user for this database
CREATE USER 'username'@'127.0.0.1' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON STUDENT_REGISTRATION_SYSTEM.* TO 'username'@'127.0.0.1';
FLUSH privileges;