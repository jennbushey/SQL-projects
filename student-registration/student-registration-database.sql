-- Create database
DROP DATABASE IF EXISTS STUDENT_REGISTRATION_SYSTEM;
CREATE DATABASE STUDENT_REGISTRATION_SYSTEM; 
USE STUDENT_REGISTRATION_SYSTEM;

-- Create STUDENT table
DROP TABLE IF EXISTS STUDENT;
CREATE TABLE STUDENT (
	StudentID			varchar(10) not null,
	FirstName			varchar(50),
	LastName			varchar(50),
    Location			varchar(100),
    -- apply primary key
	primary key (StudentID)
);

-- Create COURSE table
DROP TABLE IF EXISTS COURSE;
CREATE TABLE COURSE (
	CourseID			varchar(10) not null,
	CourseName			varchar(50),
	CourseTitle			varchar(50),
    -- apply primary key
	primary key (CourseID)
);

DROP TABLE IF EXISTS REGISTRATION;
CREATE TABLE REGISTRATION (
	RegistrationID		varchar(10)	not null,
	CourseID			varchar(10),
	StudentID			varchar(10),
    -- apply primary key
	primary key (RegistrationID),
    -- apply foreign keys
	foreign key (CourseID) references COURSE(CourseID),
    foreign key (StudentID) references STUDENT(StudentID)
);

-- Create specific user for this database so Java doesn't recieve root password
CREATE USER 'username'@'127.0.0.1' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON STUDENT_REGISTRATION_SYSTEM.* TO 'username'@'127.0.0.1';
FLUSH privileges;

-- Populate STUDENT table
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('2585', 'Willie', 'Wiley', '5747 Anderson Squares Suite 096 South Ashley, NB Y1H4K5') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('5268', 'Jesse', 'Diaz', '5291 Mendoza Freeway Suite 819 Kristenville, PE M3J2H6') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('7745', 'Julie', 'Roy', '5243 Scott Brook Port William, NL R9T2R7') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('4253', 'Nicole', 'Lewis', '85430 Anthony Lane Apt. 045 Morganburgh, NS Y8Y 4T4') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('2932', 'Rhonda', 'Smith', '7120 Jennings Corners Gregorybury, BC S5N 5B4') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('1559', 'Andrew', 'Miller', '2604 Daniel Extension Suite 814 Parkerfurt, SK A9X4M7') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('477', 'Christopher', 'Fitzpatrick', '682 Manuel Mountains Davidmouth, AB J4E8L1') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('715', 'Stephanie', 'Knight', '7545 Patrick Grove Apt. 581 East Amberborough, NT M3M 5J5') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('8189', 'Jeremy', 'Tran', '97715 Ward Parks Calvinport, SK J5T 9B1') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('2614', 'Michael', 'Summers', '8420 Adam Squares New Nicolechester, MB M3N3X4') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('6345', 'Daniel', 'King', '5233 Hendrix Rapid Lake Stephen, AB S4R 8N8') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('1037', 'Debra', 'Miller', '76810 Johns Landing Apt. 305 Nicholasport, NL E1N 8R1') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('7791', 'Jennifer', 'Taylor', '042 Brian Fields North Michael, SK A7S 7L4') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('7934', 'Nathan', 'Grant', '4395 Michael Unions Suite 206 Lake Aaron, PE M7K3C2') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('3162', 'Zachary', 'Leonard', '2107 Miller Course Adrianahaven, BC B7E 5S3') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('5698', 'Keith', 'Thomas', '5661 Castro Trace Lake Jason, NU H4T6Y9') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('6541', 'John', 'Williams', '654 Brent Square Millerberg, MB T6J 9C8') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('4962', 'Daniel', 'Wood', '12736 Shane Mall Suite 658 Ashleybury, NS M8B6S4') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('3963', 'Amber', 'Rogers', '09316 Sosa Dam Suite 879 West Adam, NS X6Y 4C1') ;
INSERT INTO STUDENT (StudentID, FirstName, LastName, Location) VALUES ('5741', 'Thomas', 'Rich', '4863 Johnson Springs Cherylmouth, NT S3P5M2') ;


-- Populate COURSE table
INSERT INTO COURSE (CourseID, CourseName, CourseTitle) VALUES ('241', 'ENCH', 'Organized high-level forecast') ;
INSERT INTO COURSE (CourseID, CourseName, CourseTitle) VALUES ('128', 'ENEL', 'Versatile empowering hub') ;
INSERT INTO COURSE (CourseID, CourseName, CourseTitle) VALUES ('192', 'ENEE', 'Advanced dedicated portal') ;
INSERT INTO COURSE (CourseID, CourseName, CourseTitle) VALUES ('375', 'ENEE', 'Customizable didactic projection') ;
INSERT INTO COURSE (CourseID, CourseName, CourseTitle) VALUES ('313', 'ENEE', 'Future-proofed 24hour approach') ;
INSERT INTO COURSE (CourseID, CourseName, CourseTitle) VALUES ('104', 'ENCH', 'Decentralized coherent Graphic Interface') ;
INSERT INTO COURSE (CourseID, CourseName, CourseTitle) VALUES ('382', 'ENCH', 'Expanded multimedia toolset') ;
INSERT INTO COURSE (CourseID, CourseName, CourseTitle) VALUES ('289', 'ENGG', 'Progressive transitional moratorium') ;
INSERT INTO COURSE (CourseID, CourseName, CourseTitle) VALUES ('377', 'ENCH', 'Visionary directional project') ;
INSERT INTO COURSE (CourseID, CourseName, CourseTitle) VALUES ('384', 'ENEL', 'Seamless leadingedge help-desk') ;


-- Populate REGISTRATION table
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('40250', '241', '3963') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('19353', '382', '6541') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('94399', '375', '4253') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('15723', '375', '477') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('70641', '192', '4253') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('75512', '128', '477') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('80401', '104', '3162') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('25957', '289', '7745') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('61854', '382', '6345') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('39839', '128', '4962') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('80070', '241', '7745') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('36460', '384', '6345') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('95927', '375', '2932') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('53495', '375', '7791') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('69602', '375', '4962') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('68345', '384', '7745') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('9464', '375', '2614') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('5610', '128', '1559') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('6587', '192', '7745') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('48394', '313', '1037') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('19373', '128', '1559') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('91850', '384', '5741') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('97052', '382', '7791') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('14095', '289', '8189') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('32156', '384', '5741') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('50488', '289', '4253') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('3950', '382', '5698') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('84228', '375', '6345') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('24176', '289', '7791') ;
INSERT INTO REGISTRATION (RegistrationID, CourseID, StudentID) VALUES ('45449', '241', '2932') ;