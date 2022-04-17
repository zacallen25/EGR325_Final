-- For my 2 files, run Make_Staff, then Insert_Staff. Insert_Staff is a stored procedure to auto-populate Doctor and Receptionist based on the job description
-- create the database
DROP DATABASE IF EXISTS DrDatabase;

CREATE DATABASE DrDatabase;

-- select the database
USE DrDatabase;

-- Make the staff-related tables
create table Staff (
    StaffID smallint primary key auto_increment,
    -- I'm making this auto incrementing, but that can be changed
    FirstName varchar(15) NOT NULL,
    LastName varchar(20) NOT NULL,
    JobDescription varchar(40),
    DateHired date NOT NULL,
    Salary int NOT NULL,
    OfficeNum smallint
);

create table StaffContact (
    StaffID smallint primary key,
    PhoneNum bigint,
    Email varchar(50),
    foreign key (StaffID) references Staff(StaffID)
);

create table Doctor (
    StaffID smallint primary key,
    foreign key (StaffID) references Staff(StaffID)
);

create table Receptionist (
    StaffID smallint primary key,
    FrontDeskNumber bigint,
    foreign key (StaffID) references Staff(StaffID)
);

-- Populating with dummy data
-- Ideas for future checks: 
-- 1) Make sure that the OfficeNum does not match any others (one office per staff member doctor)
-- 2) Make sure that phone numbers inputted have 10 numbers
insert into
    Staff(
        StaffID,
        FirstName,
        LastName,
        JobDescription,
        DateHired,
        Salary,
        OfficeNum
    )
values
    (
        1,
        "Zac",
        "Allen",
        "Doctor",
        4 / 15 / 2001,
        10000000,
        25
    ),
    (
        2,
        "Ezekial",
        "Ramirez",
        "Doctor",
        5 / 15 / 1987,
        5000000,
        28
    ),
    (
        3,
        "Christopher",
        "Schilling",
        "Doctor",
        9 / 12 / 2020,
        1006578,
        15
    ),
    (
        4,
        "Collin",
        "Morris",
        "Doctor",
        5 / 8 / 2018,
        10000000,
        25
    ),
    (
        5,
        "Larry",
        "Clement",
        "Receptionist",
        4 / 14 / 2021,
        2000,
        11
    ),
    (
        6,
        "Alyssa",
        "Allen",
        "Receptionist",
        4 / 15 / 2001,
        200000,
        12
    ),
    (7, "Rebel", "Friend", "Doctor", 11 / 6 / 2007, 0, 1);

insert into
    StaffContact(StaffID, PhoneNum, Email)
values
    (1, 6613304417, "zachary.allen2500@gmail.com"),
    (2, 1234567891, "zeke_coolguy@amazing.com"),
    (3, 9876543212, "christ_great@terrific.com"),
    (4, 9638527413, "collin_morris@coolness.com"),
    (5, 1479632584, "surfer_dude@gmail.com"),
    (6, 8523641795, "amazingwife@gmail.com"),
    (7, 1111111111, "completesaga@gmail.com");