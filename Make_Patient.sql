-- Colin Morris-Moncada
-- Dr. Database Final 
-- Patient Table
use DrDatabase;

-- Drop Child Database with Referencing Key First
drop table if exists PatientContact;
drop table if exists Patient;

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
    PatientID smallint primary key,
    PhoneNum bigint,
    Email varchar(50),
    Address varchar(50),
    foreign key (PatientID) references Patient(PatientID)
);

insert into
    Patient(
        PatientID,
        FirstName,
        LastName,
        SSN,
        Height,
        Weight,
        Age,
        Gender,
        BloodType
    )
values
    (
        1,
        "Colin",
        "Morris",
        "908758961",
        1.6,
        175,
        22,
        "M",
        "A-"
    )