-- For my 2 files, run Make_Staff, then Insert_Staff

use DrDatabase;

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


select * from Receptionist;
