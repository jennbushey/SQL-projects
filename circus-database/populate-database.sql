# ENSF 608 Final Design Project - Build and Populate Database
# Mehreen Akmal, Jenn Bushey,  Eric Diep, Hao Liu

DROP DATABASE IF EXISTS CIRCUS;
CREATE DATABASE CIRCUS; 
USE CIRCUS;

DROP TABLE IF EXISTS `SHOW`;
CREATE TABLE `SHOW` (
    Name            varchar(25) not null,
    Year            INT not null, 
    Sponsor         varchar(25),
    Producer        varchar(25),
    PRIMARY KEY (Name, Year)
);

INSERT INTO `SHOW` (Name, Year, Sponsor, Producer)
VALUES
('Corteo', '2006', 'SponsorA', 'Producer1'),
('Alegria', '2012', 'SponsorB', 'Producer2'),
('Kooza', '2018', 'SponsorC', 'Producer3');


DROP TABLE IF EXISTS VENUE;
CREATE TABLE VENUE (
    VenueID         	varchar(255) not null, 
    Name         		varchar(255),
    Street         		varchar(255),
    City        		varchar(255),
    Province        	varchar(255),
    Capacity        	INT,
    Transit_Accessible	boolean,
    PRIMARY KEY (VenueID)
);

INSERT INTO Venue (VenueID, Name, Street, City, Province, Capacity, Transit_Accessible)
VALUES
('VEN001', 'The Grand Hall', '123 Main Street', 'Toronto', 'Ontario', 1000, true),
('VEN002', 'Downtown Arena', '456 Oak Avenue', 'Vancouver', 'British Columbia', 1500, false),
('VEN003', 'Riverside Theater', '789 Elm Boulevard', 'Montreal', 'Quebec', 800, true),
('VEN004', 'Harbor Convention Center', '101 Pine Lane', 'Halifax', 'Nova Scotia', 2000, true),
('VEN005', 'Meadow Stadium', '202 Maple Street', 'Calgary', 'Alberta', 1200, false),
('VEN006', 'Mountain Arena', '303 Birch Road', 'St. John\'s', 'Newfoundland and Labrador', 1800, true),
('VEN007', 'Sunset Pavilion', '404 Cedar Court', 'Winnipeg', 'Manitoba', 900, false),
('VEN008', 'Lakeview Hall', '505 Spruce Place', 'Regina', 'Saskatchewan', 1600, true),
('VEN009', 'Skyline Auditorium', '606 Fir Avenue', 'Charlottetown', 'Prince Edward Island', 1300, true),
('VEN010', 'Central Convention Center', '707 Pine Lane', 'Fredericton', 'New Brunswick', 2200, false);


DROP TABLE IF EXISTS HOSTED_BY;
CREATE TABLE HOSTED_BY (
    ShowName            varchar(25) not null,
    ShowYear            INT not null,
    VenueID         	varchar(255) not null,
    Date         		date,
    Location         	varchar(255),
    FOREIGN KEY (ShowName, ShowYear) REFERENCES `SHOW`(Name, Year) ON UPDATE CASCADE ON DELETE CASCADE, 
    FOREIGN KEY (VenueID) REFERENCES VENUE(VENUEID) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO HOSTED_BY (ShowName, ShowYear, VenueID, Date, Location)
VALUES
('Corteo', '2006', 'VEN001', '2024-01-15', 'Main Stage'),
('Alegria', '2012', 'VEN003', '2024-02-20', 'Riverside Hall'),
('Kooza', '2018', 'VEN006', '2024-03-25', 'Mountain Arena'),
('Corteo', '2006', 'VEN008', '2024-04-10', 'Lakeview Pavilion'),
('Alegria', '2012', 'VEN005', '2024-05-18', 'Meadow Stadium'),
('Kooza', '2018', 'VEN010', '2024-06-22', 'Central Convention Center'),
('Corteo', '2006', 'VEN002', '2024-07-15', 'Downtown Arena'),
('Alegria', '2012', 'VEN009', '2023-08-20', 'Skyline Auditorium'),
('Kooza', '2018', 'VEN004', '2023-09-25', 'Harbor Convention Center'),
('Corteo', '2006', 'VEN007', '2023-12-10', 'Sunset Pavilion');


DROP TABLE IF EXISTS PERFORMER;
CREATE TABLE PERFORMER (
    PerformerID         varchar(25) not null,
    FName               varchar(255),
    LName               varchar(255),
    Citizenship         varchar(255),
    Birthdate           date,
    Diet                varchar(255),
    ShowName            varchar(25) not null,
    ShowYear            INT not null,
    UnderstudyID        varchar(25),
    PRIMARY KEY (PerformerID),
    FOREIGN KEY (ShowName, ShowYear) REFERENCES `SHOW`(Name, Year) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO PERFORMER (PerformerID, FName, LName, Citizenship, Birthdate, Diet, ShowName, ShowYear, UnderstudyID)
VALUES
('PER001', 'Alice', 'Smith', 'USA', '2002-01-01', 'Vegetarian', 'Corteo', '2006', 'PER002'),
('PER002', 'Bob', 'Johnson', 'Canada', '1995-01-01', 'None', 'Alegria', '2012', 'PER003'),
('PER003', 'Charlie', 'Williams', 'UK', '1990-01-01', 'Vegan', 'Kooza', '2018', 'PER004'),
('PER004', 'David', 'Brown', 'Australia', '1994-01-01', 'Vegetarian', 'Corteo', '2006', 'PER005'),
('PER005', 'Emily', 'Davis', 'USA', '2003-01-01', 'None', 'Alegria', '2012', 'PER006'),
('PER006', 'Frank', 'Jones', 'Canada', '1996-01-01', 'Vegetarian', 'Kooza', '2018', 'PER007'),
('PER007', 'Grace', 'Taylor', 'France', '1991-01-01', 'Vegan', 'Corteo', '2006', 'PER008'),
('PER008', 'Henry', 'Moore', 'Germany', '1988-01-01', 'None', 'Alegria', '2012', 'PER009'),
('PER009', 'Ivy', 'Clark', 'Spain', '1992-01-01', 'Vegan', 'Kooza', '2018', 'PER010'),
('PER010', 'Jack', 'White', 'Italy', '1993-01-01', 'None', 'Corteo', '2006', 'PER001');

ALTER TABLE PERFORMER ADD FOREIGN KEY (UnderstudyID) 
	REFERENCES PERFORMER(PerformerID) 
	ON UPDATE CASCADE 
	ON DELETE SET NULL;


DROP TABLE IF EXISTS EMERGENCY_CONTACTS;
CREATE TABLE EMERGENCY_CONTACTS (
    PerformerID         varchar(25) not null,
    FName               varchar(255),
    LName               varchar(255),
    Phone_Number        varchar(12),
    Relationship        varchar(255),
	PRIMARY KEY (PerformerID, FName, LName), 
    FOREIGN KEY (PerformerID) 
    REFERENCES PERFORMER (PerformerID) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE
);

INSERT INTO EMERGENCY_CONTACTS (PerformerID, FName, LName, Phone_Number, Relationship)
VALUES
('PER001', 'John', 'Doe', '123-456-7890', 'Parent'),
('PER002', 'Jane', 'Smith', '987-654-3210', 'Sibling'),
('PER003', 'Robert', 'Johnson', '555-123-4567', 'Spouse'),
('PER004', 'Emily', 'Brown', '321-654-9870', 'Friend'),
('PER005', 'Michael', 'Taylor', '111-222-3333', 'Parent'),
('PER006', 'Sophia', 'Jones', '444-555-6666', 'Sibling'),
('PER007', 'William', 'Clark', '777-888-9999', 'Friend'),
('PER008', 'Olivia', 'Moore', '888-777-6666', 'Spouse'),
('PER009', 'James', 'White', '333-222-1111', 'Parent'),
('PER010', 'Emma', 'Anderson', '999-888-7777', 'Sibling');


DROP TABLE IF EXISTS AERIALIST;
CREATE TABLE AERIALIST(
PerformerID         varchar(25) not null,
Sport               varchar(255),
Equipment           varchar(255),
FOREIGN KEY (PerformerID) 
	REFERENCES PERFORMER (PerformerID) 
	ON UPDATE CASCADE 
	ON DELETE CASCADE
);

INSERT INTO AERIALIST (PerformerID, Sport, Equipment)
VALUES
('PER001', 'Aerial Silks', 'Silks, Harness'),
('PER003', 'Trapeze', 'Bars, Ropes'),
('PER005', 'Aerial Hoop', 'Hoop'),
('PER007', 'Aerial Straps', 'Straps, Harness'),
('PER009', 'Pole Dance', 'Pole, Grip Aids');


DROP TABLE IF EXISTS ENTERTAINER;
CREATE TABLE ENTERTAINER(
PerformerID         varchar(25) not null,
Main_Act               varchar(255),
FOREIGN KEY (PerformerID) 
	REFERENCES PERFORMER (PerformerID)
	ON UPDATE CASCADE 
	ON DELETE CASCADE
);

INSERT INTO ENTERTAINER (PerformerID, Main_Act)
VALUES
('PER002', 'Clown Performance'),
('PER004', 'Magician Show'),
('PER006', 'Juggling Acts'),
('PER008', 'Fire Dancing'),
('PER010', 'Mime Performance');


DROP TABLE IF EXISTS MUSICIAN;
CREATE TABLE MUSICIAN(
PerformerID         varchar(25) not null,
INSTRUMENT               varchar(255) not null,
PRIMARY KEY (PerformerID, INSTRUMENT), 
FOREIGN KEY (PerformerID) 
	REFERENCES PERFORMER (PerformerID)
	ON UPDATE CASCADE 
	ON DELETE CASCADE
);

INSERT INTO MUSICIAN (PerformerID, INSTRUMENT)
VALUES
('PER001', 'Violin'),
('PER003', 'Piano'),
('PER005', 'Flute'),
('PER007', 'Guitar'),
('PER007', 'Drums'),
('PER009', 'Saxophone');


DROP TABLE IF EXISTS MEDICATION;
CREATE TABLE MEDICATION(
PerformerID         varchar(25) not null,
Medication          varchar(255) not null,
PRIMARY KEY (PerformerID, Medication),  
FOREIGN KEY (PerformerID) 
	REFERENCES PERFORMER (PerformerID)
	ON UPDATE CASCADE 
	ON DELETE CASCADE
);

INSERT INTO MEDICATION (PerformerID, Medication)
VALUES
('PER002', 'Allergy Medication'),
('PER003', 'Asthma Inhaler'),
('PER003', 'Allergy Medication'),
('PER004', 'Pain Reliever'),
('PER006', 'Iron Suppplemnets'),
('PER007', 'Vitamin Supplements'),
('PER008', 'Motion Sickness Medication'),
('PER008', 'Allergy Medication'),
('PER010', 'Cold and Flu Medication');

DELIMITER //
CREATE TRIGGER enforce_capacity_limit
BEFORE UPDATE ON VENUE
FOR EACH ROW
BEGIN
    IF NEW.Capacity < 300 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Capacity limit below minimum requirement (min: 300)';
    END IF;
END;
//
DELIMITER ;


CREATE TRIGGER prevent_delete_emergency_contact
BEFORE DELETE ON EMERGENCY_CONTACTS FOR EACH ROW
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Emergency contact Can Not be deleted because each performer must have an emergency contact';
