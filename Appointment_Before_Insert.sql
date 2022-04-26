use DrDatabase; 
DROP TRIGGER IF EXISTS Appointment_Before_Insert; 

DELIMITER // 

CREATE TRIGGER Appointment_Before_Insert
	BEFORE INSERT ON Appointment
	FOR EACH ROW 
BEGIN
IF EXISTS (SELECT StartTime, EndTime, DateBooked, DoctorID FROM Appointment WHERE DateBooked = New.DateBooked && DoctorID = new.DoctorID && (new.StartTime > StartTime && new.EndTime < Endtime)  
|| (new.EndTime > StartTime && new.EndTime < Endtime) 
|| (new.StartTime > StartTime && new.StartTime < EndTime)) THEN
	SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = "Error, overlapping times for appointment."; -- This will throw an error if true!!
END IF;
END//
DELIMITER ; 



