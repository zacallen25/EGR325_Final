-- this is for final project by Zeek
/*
 Multiline comment
 This is also an inline comment so it gets ignored
 even in the middle of a full line of code
 */
# another style of commenting
use DrDatabase;

-- maybe drop tables if they already exist
drop table if exists doctorNotes;

drop table if exists patientCondition;

CREATE TABLE doctorNotes (
    appointmentID BIGINT UNSIGNED PRIMARY KEY,
    doctorNotes VARCHAR(280) -- twitter character limit I found said 280
    -- actor_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    -- make aptId a foreign id referencing appointment table
    -- FOREIGN KEY (appointmentID) REFERENCES booking(appointment)
);

CREATE TABLE patientCondition (
    patientID BIGINT UNSIGNED PRIMARY KEY,
    -- this needs to be a foreign key as well
    diseaseName VARCHAR(280),
    genetic BOOLEAN,
    onsetCause VARCHAR(280),
    treatedCondition BOOLEAN -- my assumption here is that treated condition meant yes or no
    -- FOREIGN KEY (patientID) REFERENCES patient(patientID)
);