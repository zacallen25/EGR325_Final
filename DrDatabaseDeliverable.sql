-- For my 2 files, run Make_Staff, then Insert_Staff. Insert_Staff is a stored procedure to auto-populate Doctor and Receptionist based on the job description

-- create the database
DROP DATABASE IF EXISTS DrDatabase;
CREATE DATABASE DrDatabase;

-- select the database
USE DrDatabase;

-- Make the staff-related tables

create table Staff
(
StaffID		smallint		primary key		auto_increment, 	-- I'm making this auto incrementing, but that can be changed
FirstName		varchar(15) 	NOT NULL,
LastName		varchar(20) 	NOT NULL,
JobDescription		varchar(40),
DateHired		date 	NOT NULL,
Salary		int 	NOT NULL,
OfficeNum	smallint 
);

create table StaffContact
(
StaffID		smallint		primary key,
PhoneNum	bigint,
Email	varchar(50),
foreign key (StaffID) references Staff(StaffID)
);

create table Doctor
(
StaffID		smallint		primary key,
foreign key (StaffID) references Staff(StaffID)
);

create table Receptionist
(
StaffID		smallint		primary key,
FrontDeskNumber		bigint,
foreign key (StaffID) references Staff(StaffID)
);

CREATE TABLE Patient(
    PatientID smallint primary key auto_increment,
    FirstName varchar(15) NOT NULL,
    LastName varchar(20) NOT NULL,
    SSN char(9) NOT NULL,
    Height smallint,
    -- in meters
    Weight smallint,
    -- in pounds
    Age smallint,
    Gender varchar(1),
    BloodType varchar(2) NOT NULL
);

CREATE TABLE PatientContact(
    PatientID smallint primary key auto_increment,
    PhoneNum bigint,
    Email varchar(50),
    Address varchar(50),
    foreign key (PatientID) references Patient(PatientID)
);

CREATE TABLE patientCondition (
	patientID			smallint PRIMARY KEY, -- this needs to be a foreign key as well
    diseaseName			VARCHAR(280),
    genetic				BOOLEAN,
    onsetCause			VARCHAR(280),
    treatedCondition	BOOLEAN, -- my assumption here is that treated condition meant yes or no
    FOREIGN KEY (patientID) REFERENCES patient(patientID)
);

CREATE TABLE Pharmacy 
(
PharmacyID int AUTO_INCREMENT PRIMARY KEY, 
PharmacyName Varchar(50) NOT NULL, 
Hours Varchar(50) NOT NULL, -- So we can do MWF 9-5 and such  
Location Varchar(50) NOT NULL
);

CREATE TABLE Appointment
(
AppointmentID int primary key auto_increment, -- can change this if need be 
PatientID smallint, 
DoctorID smallint, -- just gonna make it so that Doctor ID can be null if need be 
StartTime Time NOT NULL, -- only other places where columns are not null
EndTime Time NOT NULL, 
DateBooked Date NOT NULL, 
ReasonBooked varchar(200), 
IsBooked bool default FALSE,

foreign key(PatientID) references Patient(PatientID) ON DELETE SET NULL ON UPDATE CASCADE,  
foreign key(DoctorID) references Doctor (StaffID) ON DELETE SET NULL ON UPDATE CASCADE -- this is if a doctor leaves perhaps make a trigger for that
);

CREATE TABLE Diagnosis
(
AppointmentID int, 
NamePrescription varchar(50), 
PatientID smallint,
PharmacyID int DEFAULT NULL, 
Dosage varchar(50) NOT NULL, -- Dosage can also be the exercise descript
Refills smallint NOT NULL, 
PhysicalActivity bool NOT NULL, 

PRIMARY KEY (AppointmentID, NamePrescription),
FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID) ON DELETE RESTRICT ON UPDATE RESTRICT, -- may need to discuss what to do with this 
FOREIGN KEY (PharmacyID) REFERENCES Pharmacy (PharmacyID) ON UPDATE CASCADE,
FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) ON DELETE RESTRICT ON UPDATE CASCADE -- also discuss 
);

-- this is for final project by Zeek
/*
Multiline comment
This is also an inline comment so it gets ignored
even in the middle of a full line of code
*/

# another style of commenting
-- maybe drop tables if they already exist
CREATE TABLE doctorNotes (
	AppointmentID		INT PRIMARY KEY,
    DoctorNotes			VARCHAR(280),
    -- twitter character limit I found said 280    
    FOREIGN KEY (AppointmentID) REFERENCES Appointment (AppointmentID)
);
-- Populating with dummy data

-- Ideas for future checks: 
-- 1) Make sure that the OfficeNum does not match any others (one office per staff member doctor)
-- 2) Make sure that phone numbers inputted have 10 numbers

insert into Staff(StaffID, FirstName, LastName, JobDescription, DateHired, Salary, OfficeNum) values 
	(1, "Zac", "Allen", "Doctor", 4/15/2001, 10000000, 25),
    (2, "Ezekial", "Ramirez", "Doctor", 5/15/1987, 5000000, 28),
    (3, "Christopher", "Schilling", "Doctor", 9/12/2020, 1006578, 15),
    (4, "Collin", "Morris", "Doctor", 5/8/2018, 10000000, 25),
    (5, "Larry", "Clement", "Receptionist", 4/14/2021, 2000, 11),
    (6, "Alyssa", "Allen", "Receptionist", 4/15/2001, 200000, 12),
    (7, "Rebel", "Friend", "Doctor", 11/6/2007, 0, 1);


insert into StaffContact(StaffID, PhoneNum, Email) values 
	(1, 6613304417, "zachary.allen2500@gmail.com"),
    (2, 1234567891, "zeke_coolguy@amazing.com"),
    (3, 9876543212, "christ_great@terrific.com"),
    (4, 9638527413, "collin_morris@coolness.com"),
    (5, 1479632584, "surfer_dude@gmail.com"),
    (6, 8523641795, "amazingwife@gmail.com"),
    (7, 1111111111, "completesaga@gmail.com");
    
DROP PROCEDURE IF EXISTS insertStaff;

DELIMITER //
CREATE procedure insertStaff()
BEGIN
	declare finishedReading BOOL default false;
    declare JobDesc	varchar(40);
    declare ID smallint;
	declare staffcursor cursor for 
		select StaffID, JobDescription from Staff;
	DECLARE CONTINUE HANDLER FOR NOT FOUND set finishedReading = true;
    open staffcursor;
    fetch from staffcursor into ID, JobDesc;
    
    while not finishedReading do
		if JobDesc = "Doctor" then 
			insert into Doctor(StaffID) values (ID);
		elseif JobDesc = "Receptionist" then
			insert into Receptionist(StaffID) values (ID);
        end if;
		fetch from staffcursor into ID, JobDesc;
        
    END while;
    close staffcursor;
    
END//
DELIMITER ;

call insertStaff();

update receptionist set FrontDeskNumber = 1326897541 where StaffID = 5;
update receptionist set FrontDeskNumber = 9589856328 where StaffID = 6;

INSERT INTO Pharmacy(PharmacyName, Hours, Location ) VALUES 
 ("Goodwins","Buisness Days: 9-5","45648 Arbon Ln. Lake Reggie"),
 ("CVS","Buisness Days: 9-5","98747 Duron Duron. St. Fortuna"),
 ("Rite Aid","Buisness Days: 9-5","32457 Blah St. Lake Reggie"),
 ("Umbrella Corp.","Buisness Days: 7-5","98631 Rose Rd. Fortuna"),
 ("Placebo CO.","Buisness Days: 9-2","47854 Everpine St. Lake Reggie");
 
INSERT INTO Patient(FirstName, LastName, SSN, Height, Weight, Age, Gender, BloodType) VALUES
 ("Colin", "Morris", "908758961", 1.6, 175, 22, "M", "A-");
 
 INSERT INTO Appointment(DoctorID, StartTime, EndTime, DateBooked) VALUES
 (1,"9:30","10:00","2022/05/21"),
 (1,"10:15","10:45","2022/05/21"),
 (2,"9:30","10:00","2022/05/21"),
 (2,"11:00","11:30","2022/05/21"),
 (2,"1:00","2:00","2022/05/21"),
 (3,"9:45","10:15","2022/05/21"),
 (4,"4:30","5:00","2022/05/21"),
 (7,"9:30","10:30","2022/05/21"),
 (7,"10:30","11:00","2022/05/21");
 
 INSERT INTO Appointment(PatientID, DoctorID, StartTime, EndTime, DateBooked, ReasonBooked, IsBooked) VALUES
 (1,7,"3:30","4:00","2022/05/21", "Minor Headaches", TRUE);
 
 INSERT INTO DIAGNOSIS(AppointmentID, NamePrescription, PatientID, PharmacyID, Dosage, Refills, PhysicalActivity) VALUES
 (10, "Ibuprofin", 1, 2, "30 Pills", 0, FALSE);