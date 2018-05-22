create schema eventor;

use eventor;

CREATE TABLE `eventor`.`main_event` (
  `Main_Event_Id` INT NOT NULL,
  `Main_Event_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Main_Event_Id`));

ALTER TABLE `eventor`.`main_event` 
ADD COLUMN `Start_Date` DATE NOT NULL AFTER `Main_Event_Name`,
ADD COLUMN `End_Date` DATE NOT NULL AFTER `Start_Date`;

CREATE TABLE `eventor`.`events` (
  `Event_Id` INT NOT NULL,
  `Event_Name` VARCHAR(45) NOT NULL,
  `Start_Date` DATE NOT NULL,
  `End_Date` DATE NOT NULL,
  `Start_Time` TIME(6) NOT NULL,
  `End_Time` TIME(6) NOT NULL,
  PRIMARY KEY (`Event_Id`));
  
  ALTER TABLE `eventor`.`events` 
CHANGE COLUMN `Event_Id` `Event_Id` VARCHAR(10) NOT NULL ;

ALTER TABLE `eventor`.`main_event` 
CHANGE COLUMN `Main_Event_Id` `Main_Event_Id` VARCHAR(10) NOT NULL ;

CREATE TABLE `eventor`.`relation_event_mainevent` (
  `Event_Id` VARCHAR(10) NOT NULL,
  `Main_Event_Id` VARCHAR(10) NOT NULL,
  INDEX `eveid_idx` (`Event_Id` ASC),
  INDEX `meveid_idx` (`Main_Event_Id` ASC),
  CONSTRAINT `eveid`
    FOREIGN KEY (`Event_Id`)
    REFERENCES `eventor`.`events` (`Event_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `meveid`
    FOREIGN KEY (`Main_Event_Id`)
    REFERENCES `eventor`.`main_event` (`Main_Event_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `eventor`.`participants` (
  `Registration_Id` VARCHAR(10) NOT NULL,
  `Participant_Name` VARCHAR(45) NOT NULL,
  `Participant_Email_Id` VARCHAR(50) NOT NULL,
  `College` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Registration_Id`));

CREATE TABLE `eventor`.`relation_events_participants` (
  `Event_Id` VARCHAR(10) NOT NULL,
  INDEX `eveid2_idx` (`Event_Id` ASC),
  CONSTRAINT `eveid2`
    FOREIGN KEY (`Event_Id`)
    REFERENCES `eventor`.`events` (`Event_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `eventor`.`event_coordinator` (
  `Event_Coordinator_Id` VARCHAR(10) NOT NULL,
  `Event_Coordinator_Name` VARCHAR(45) NOT NULL,
  `Event_Coordinator_Contact` INT(10) NOT NULL,
  `Event_Coordinator_Email_Id` VARCHAR(50) NOT NULL,
  `Post` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Event_Coordinator_Id`));

CREATE TABLE `eventor`.`relation_event_eventcoordinator` (
  `Event_Id` VARCHAR(10) NOT NULL,
  INDEX `eveid3_idx` (`Event_Id` ASC),
  CONSTRAINT `eveid3`
    FOREIGN KEY (`Event_Id`)
    REFERENCES `eventor`.`events` (`Event_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `eventor`.`volunteers` (
  `Volunteer_Id` VARCHAR(10) NOT NULL,
  `Volunteer_Name` VARCHAR(45) NOT NULL,
  `Volunteer_Contact` INT(10) NOT NULL,
  `Volunteer_Email_Id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Volunteer_Id`));

CREATE TABLE `eventor`.`relation_eventcoordinator_volunteer` (
  `Volunteer_Id` VARCHAR(10) NOT NULL,
  INDEX `volid_idx` (`Volunteer_Id` ASC),
  CONSTRAINT `volid`
    FOREIGN KEY (`Volunteer_Id`)
    REFERENCES `eventor`.`volunteers` (`Volunteer_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `eventor`.`guests` (
  `Guest_Id` VARCHAR(10) NOT NULL,
  `Guest_Name` VARCHAR(45) NOT NULL,
  `Guest_Email_Id` VARCHAR(50) NOT NULL,
  `Arrival_Time` TIME(6) NOT NULL,
  `Departure_Time` TIME(6) NOT NULL,
  PRIMARY KEY (`Guest_Id`));

CREATE TABLE `eventor`.`relation_events_guests` (
  `Event_Id` VARCHAR(10) NOT NULL,
  INDEX `eveid4_idx` (`Event_Id` ASC),
  CONSTRAINT `eveid4`
    FOREIGN KEY (`Event_Id`)
    REFERENCES `eventor`.`events` (`Event_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `eventor`.`allocations` (
  `Sr_No` INT NOT NULL AUTO_INCREMENT,
  `Location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sr_No`));

CREATE TABLE `eventor`.`relation_allocations_events` (
  `Event_Id` VARCHAR(10) NOT NULL,
  INDEX `eveid5_idx` (`Event_Id` ASC),
  CONSTRAINT `eveid5`
    FOREIGN KEY (`Event_Id`)
    REFERENCES `eventor`.`events` (`Event_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `eventor`.`resources` (
  `Sr_No` INT NOT NULL AUTO_INCREMENT,
  `Event_Budget` VARCHAR(45) NOT NULL,
  `Materials` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sr_No`));

CREATE TABLE `eventor`.`relation_event_resources` (
  `Event_Id` VARCHAR(10) NOT NULL,
  INDEX `eveid6_idx` (`Event_Id` ASC),
  CONSTRAINT `eveid6`
    FOREIGN KEY (`Event_Id`)
    REFERENCES `eventor`.`events` (`Event_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `eventor`.`relation_event_mainevent` 
ADD COLUMN `Sr_No` INT NOT NULL AUTO_INCREMENT FIRST,
ADD PRIMARY KEY (`Sr_No`);

ALTER TABLE `eventor`.`relation_events_participants` 
ADD COLUMN `Sr_No` INT NOT NULL AUTO_INCREMENT FIRST,
ADD COLUMN `Registration_Id` VARCHAR(10) NOT NULL AFTER `Event_Id`,
ADD PRIMARY KEY (`Sr_No`);

ALTER TABLE `eventor`.`relation_events_participants` 
ADD INDEX `regid_idx` (`Registration_Id` ASC);
ALTER TABLE `eventor`.`relation_events_participants` 
ADD CONSTRAINT `regid`
  FOREIGN KEY (`Registration_Id`)
  REFERENCES `eventor`.`participants` (`Registration_Id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `eventor`.`relation_event_eventcoordinator` 
ADD COLUMN `Sr_No` INT NOT NULL AUTO_INCREMENT FIRST,
ADD COLUMN `Event_Coordinator_Id` VARCHAR(10) NOT NULL AFTER `Event_Id`,
ADD PRIMARY KEY (`Sr_No`),
ADD INDEX `evecodid_idx` (`Event_Coordinator_Id` ASC);
ALTER TABLE `eventor`.`relation_event_eventcoordinator` 
ADD CONSTRAINT `evecodid`
  FOREIGN KEY (`Event_Coordinator_Id`)
  REFERENCES `eventor`.`event_coordinator` (`Event_Coordinator_Id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `eventor`.`relation_eventcoordinator_volunteer` 
ADD COLUMN `Sr_No` INT NOT NULL AUTO_INCREMENT FIRST,
ADD COLUMN `Event_Coordinator_Id` VARCHAR(10) NOT NULL AFTER `Volunteer_Id`,
ADD PRIMARY KEY (`Sr_No`),
ADD INDEX `evecodid2_idx` (`Event_Coordinator_Id` ASC);
ALTER TABLE `eventor`.`relation_eventcoordinator_volunteer` 
ADD CONSTRAINT `evecodid2`
  FOREIGN KEY (`Event_Coordinator_Id`)
  REFERENCES `eventor`.`event_coordinator` (`Event_Coordinator_Id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `eventor`.`relation_events_guests` 
ADD COLUMN `Guest_Id` VARCHAR(10) NOT NULL AFTER `Event_Id`,
ADD COLUMN `Sr_No` INT NOT NULL AUTO_INCREMENT AFTER `Guest_Id`,
ADD PRIMARY KEY (`Sr_No`),
ADD INDEX `gueid_idx` (`Guest_Id` ASC);
ALTER TABLE `eventor`.`relation_events_guests` 
ADD CONSTRAINT `gueid`
  FOREIGN KEY (`Guest_Id`)
  REFERENCES `eventor`.`guests` (`Guest_Id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `eventor`.`allocations` 
ADD COLUMN `Event_Id` VARCHAR(10) NOT NULL AFTER `Location`,
ADD INDEX `eveid6_idx` (`Event_Id` ASC);
ALTER TABLE `eventor`.`allocations` 
ADD CONSTRAINT `eveid6`
  FOREIGN KEY (`Event_Id`)
  REFERENCES `eventor`.`events` (`Event_Id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `eventor`.`resources` 
ADD COLUMN `Event_Id` VARCHAR(10) NOT NULL AFTER `Materials`,
ADD INDEX `eveid7_idx` (`Event_Id` ASC);
ALTER TABLE `eventor`.`resources` 
ADD CONSTRAINT `eveid7`
  FOREIGN KEY (`Event_Id`)
  REFERENCES `eventor`.`events` (`Event_Id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

INSERT INTO `eventor`.`main_event` (`Main_Event_Id`, `Main_Event_Name`, `Start_Date`, `End_Date`) VALUES ('JA2017', 'Jashn-e-Aaghaaz\'17', '2017-02-19', '2017-02-26');
INSERT INTO `eventor`.`main_event` (`Main_Event_Id`, `Main_Event_Name`, `Start_Date`, `End_Date`) VALUES ('ING2017', 'Ingenium\'17', '2017-03-17', '2017-03-19');

INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('CZAR001', 'Czar\'s War(Phase 1)', '2017-02-19', '2017-02-19', '06:30:00', '10:00:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('CZAR002', 'Czar\'s War(Phase 2)', '2017-02-22', '2017-02-22', '06:00:00', '10:00:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('CZAR003', 'Czar\'s War(Phase 3)', '2017-02-26', '2017-02-26', '01:00:00', '05:00:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('SING001', 'Singing(Stage Performance)', '2017-02-23', '2017-02-23', '06:00:00', '09:00:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('GRAF001', 'Graffiti', '2017-02-24', '2017-02-24', '11:00:00', '01:30:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('PHOT001', 'Photograpphy', '2017-02-24', '2017-02-24', '03:30:00', '06:30:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('DANC001', 'Dance+other', '2017-02-04', '2017-02-24', '07:00:00', '11:00:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('PAIN001', 'Paint Ball', '2017-02-25', '2017-02-25', '08:00:00', '01:00:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('DEBA001', 'Open House Debate', '2017-02-25', '2017-02-25', '09:00:00', '01:00:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('STOC001', 'Stock Exchange', '2017-02-25', '2017-02-25', '09:00:00', '01:00:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('TRAS001', 'Trashion', '2017-02-26', '2017-02-26', '10:00:00', '01:00:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('TREA001', 'Treasure Hunt', '2017-02-26', '2017-02-26', '01:00:00', '05:00:00');
INSERT INTO `eventor`.`events` (`Event_Id`, `Event_Name`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`) VALUES ('DJNI001', 'DJ Night', '2017-02-26', '2017-02-26', '07:00:00', '10:00:00');

INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('1', 'CZAR001', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('2', 'CZAR002', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('3', 'CZAR003', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('4', 'SING001', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('5', 'GRAF001', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('6', 'PHOT001', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('7', 'DANC001', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('8', 'PAIN001', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('9', 'DEBA001', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('10', 'STOC001', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('11', 'TRAS001', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('12', 'DJNI001', 'JA2017');
INSERT INTO `eventor`.`relation_event_mainevent` (`Sr_No`, `Event_Id`, `Main_Event_Id`) VALUES ('13', 'TREA001', 'JA2017');

INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('1', 'Parking', 'CZAR001');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('2', 'Parking', 'CZAR002');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('3', 'Parking', 'CZAR003');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('4', 'Courtyard', 'SING001');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('5', 'Courtyard', 'GRAF001');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('6', 'Courtyard', 'PHOT001');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('7', 'Courtyard', 'DANC001');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('8', 'Parking', 'PAIN001');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('9', 'Airport', 'DEBA001');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('10', 'MD Lab', 'STOC001');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('11', 'Courtyard', 'TRAS001');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('12', 'Garden Area', 'TREA001');
INSERT INTO `eventor`.`allocations` (`Sr_No`, `Location`, `Event_Id`) VALUES ('13', 'Courtyard', 'DJNI001');

INSERT INTO `eventor`.`resources` (`Sr_No`, `Event_Budget`, `Materials`, `Event_Id`) VALUES ('1', '7000', '-', 'CZAR001');
INSERT INTO `eventor`.`resources` (`Sr_No`, `Event_Budget`, `Materials`, `Event_Id`) VALUES ('2', '2000', '-', 'GRAF001');
INSERT INTO `eventor`.`resources` (`Sr_No`, `Event_Budget`, `Materials`, `Event_Id`) VALUES ('3', '20000', '-', 'PAIN001');
INSERT INTO `eventor`.`resources` (`Sr_No`, `Event_Budget`, `Materials`, `Event_Id`) VALUES ('4', '1000', '-', 'TREA001');
INSERT INTO `eventor`.`resources` (`Sr_No`, `Event_Budget`, `Materials`, `Event_Id`) VALUES ('5', '2000', '-', 'TRAS001');
INSERT INTO `eventor`.`resources` (`Sr_No`, `Event_Budget`, `Materials`, `Event_Id`) VALUES ('6', '60000', '-', 'SING001');

CREATE TABLE `eventor`.`event_budget` (
  `Sr_No` INT NOT NULL AUTO_INCREMENT,
  `Event_Id` VARCHAR(10) NOT NULL,
  `Expense_Area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sr_No`),
  INDEX `eveid8_idx` (`Event_Id` ASC),
  CONSTRAINT `eveid8`
    FOREIGN KEY (`Event_Id`)
    REFERENCES `eventor`.`resources` (`Event_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    ALTER TABLE `eventor`.`resources` 
DROP COLUMN `Materials`;

CREATE TABLE `eventor`.`winner` (
  `Sr_No` INT NOT NULL AUTO_INCREMENT,
  `Event_Id` VARCHAR(10) NOT NULL,
  `Registration_Id` VARCHAR(10) NOT NULL,
  `Position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sr_No`),
  INDEX `eveid9_idx` (`Event_Id` ASC),
  INDEX `regid1_idx` (`Registration_Id` ASC),
  CONSTRAINT `eveid9`
    FOREIGN KEY (`Event_Id`)
    REFERENCES `eventor`.`events` (`Event_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `regid1`
    FOREIGN KEY (`Registration_Id`)
    REFERENCES `eventor`.`participants` (`Registration_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('1', 'CZAR001', 'Labour Charges');
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('2', 'CZAR001', 'Material Cost');
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('3', 'CZAR001', 'Setup Charges');
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('4', 'GRAF001', 'Canvas');
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('5', 'GRAF001', 'Colors');
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('6', 'PAIN001', 'Setup Charges');
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('7', 'TREA001', 'Stationary');
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('8', 'TREA001', 'Accessories');
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('9', 'TRAS001', 'Clothes');
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('10', 'TRAS001', 'Boxes');
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('11', 'TRAS001', 'Decorative Materials');
INSERT INTO `eventor`.`event_budget` (`Sr_No`, `Event_Id`, `Expense_Area`) VALUES ('12', 'SING001', 'Stage expenses');

INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`, `Post`) VALUES ('EVC001', 'PersonA', '1234567890', 'personA@gmail.com', 'Designer');
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`, `Post`) VALUES ('EVC002', 'PersonB', '23456789', 'personB@gmail.com', 'Marketing Head');
UPDATE `eventor`.`event_coordinator` SET `Event_Coordinator_Contact`='1234567890', `Post`='Designer Head' WHERE `Event_Coordinator_Id`='EVC001';
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`) VALUES ('EVC003', 'PersonC', '34567890', 'personc@gmail.com');
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`) VALUES ('EVC004', 'PersonD', '45678901', 'persond@gmail.com');
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`) VALUES ('EVC005', 'PersonE', '5678901', 'persone@gmail.com');
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`) VALUES ('EVC006', 'PersonF', '6789012', 'personf@gmail.com');
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`) VALUES ('EVC007', 'PersonG', '7890123', 'persong@gmail.com');
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`) VALUES ('EVC008', 'PersonH', '890123', 'personh@gmail.com');
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`) VALUES ('EVC009', 'PersonI', '9012345', 'personi@gmail.com');
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`) VALUES ('EVC010', 'PersonJ', '01234567', 'personj@gmail.com');
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`) VALUES ('EVC011', 'PersonK', '9988774', 'personk@gmail.com');
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`) VALUES ('EVC012', 'PersonL', '5566112', 'personl@gmail.com');
INSERT INTO `eventor`.`event_coordinator` (`Event_Coordinator_Id`, `Event_Coordinator_Name`, `Event_Coordinator_Contact`, `Event_Coordinator_Email_Id`) VALUES ('EVC013', 'PersonM', '778855', 'personm@gmail.com');

INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V001', 'Volunteer1', '7894561', 'volunteer1@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V002', 'Volunteer2', '894561', 'volunteer2@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V003', 'Volunteer3', '561230', 'volunteer3@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V004', 'Volunteer4', '01235', 'volunteer4@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V005', 'Volunteer5', '52641', 'volunteer5@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V006', 'Volunteer6', '56412', 'volunteer6@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V007', 'Volunteer7', '879452', 'volunteer7@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V008', 'Volunteer8', '54612', 'volunteer8@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V009', 'Volunteer9', '78451', 'volunteer9@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V010', 'Volunteer10', '45120', 'volunteer10@gmal.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V011', 'Volunteer11', '78945', 'volunteer11@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V012', 'Volunteer12', '65412', 'volunteer12@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V013', 'Volunteer13', '12546', 'volunteer13@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V014', 'Volunteer14', '25416', 'volunteer14@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V015', 'Volunteer15', '5263', 'volunteer15@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V016', 'Volunteer16', '89562', 'volunteer16@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V017', 'Volunteer17', '96325', 'volunteer17@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V018', 'Volunteer18', '89523', 'volunteer18@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V019', 'Volunteer19', '963214', 'volunteer19@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V020', 'Volunteer20', '52146', 'volunteer20@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V021', 'Volunteer21', '84136', 'volunteer21@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V022', 'Volunteer22', '98563', 'volunteer22@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V023', 'Volunteer23', '97412', 'volunteer23@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V024', 'Volunteer24', '85231', 'volunteer24@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V025', 'Volunteer25', '23674', 'volunteer25@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V026', 'Volunteer26', '85210', 'volunteer26@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V027', 'Volunteer27', '874120', 'volunteer27@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V028', 'Volunteer28', '210035', 'volunteer28@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V029', 'Volunteer29', '20147', 'volunteer29@gmail.com');
INSERT INTO `eventor`.`volunteers` (`Volunteer_Id`, `Volunteer_Name`, `Volunteer_Contact`, `Volunteer_Email_Id`) VALUES ('V030', 'Volunteer30', '54120', 'volunteer30@gmail.com');

INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('1', 'V001', 'EVC001');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('2', 'V002', 'EVC001');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('3', 'V003', 'EVC001');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('4', 'V004', 'EVC002');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('5', 'V005', 'EVC002');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('6', 'V006', 'EVC002');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('7', 'V007', 'EVC003');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('8', 'V008', 'EVC003');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('9', 'V009', 'EVC004');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('10', 'V010', 'EVC004');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('11', 'V011', 'EVC005');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('12', 'V012', 'EVC005');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('13', 'V013', 'EVC006');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('14', 'V014', 'EVC006');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('15', 'V015', 'EVC007');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('16', 'V016', 'EVC007');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('17', 'V017', 'EVC008');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('18', 'V018', 'EVC008');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('19', 'V019', 'EVC009');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('20', 'V020', 'EVC009');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('21', 'V021', 'EVC010');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('22', 'V022', 'EVC010');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('23', 'V023', 'EVC011');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('24', 'V024', 'EVC011');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('25', 'V025', 'EVC011');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('26', 'V026', 'EVC012');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('27', 'V027', 'EVC012');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('28', 'V028', 'EVC013');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('29', 'V029', 'EVC013');
INSERT INTO `eventor`.`relation_eventcoordinator_volunteer` (`Sr_No`, `Volunteer_Id`, `Event_Coordinator_Id`) VALUES ('30', 'V030', 'EVC013');

INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('1', 'CZAR001', 'EVC001');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('2', 'CZAR002', 'EVC002');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('3', 'CZAR003', 'EVC003');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('4', 'DANC001', 'EVC004');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('5', 'DEBA001', 'EVC005');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('6', 'DJNI001', 'EVC006');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('7', 'GRAF001', 'EVC007');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('8', 'PAIN001', 'EVC008');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('9', 'PHOT001', 'EVC009');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('10', 'SING001', 'EVC010');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('11', 'STOC001', 'EVC011');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('12', 'TRAS001', 'EVC012');
INSERT INTO `eventor`.`relation_event_eventcoordinator` (`Sr_No`, `Event_Id`, `Event_Coordinator_Id`) VALUES ('13', 'TREA001', 'EVC013');

INSERT INTO `eventor`.`guests` (`Guest_Id`, `Guest_Name`, `Guest_Email_Id`, `Arrival_Time`, `Departure_Time`) VALUES ('G001', 'Guest1', 'guest1@gmail.com', '7:30:00', '9:30:00');
INSERT INTO `eventor`.`guests` (`Guest_Id`, `Guest_Name`, `Guest_Email_Id`, `Arrival_Time`, `Departure_Time`) VALUES ('G002', 'Guest2', 'guest2@gmail.com', '9:30:00', '1:00:00');

INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG01', 'Participant1', 'participant1@gmail.com', 'A');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG02', 'Participant2', 'participant2@gmail.com', 'B');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG03', 'Participant3', 'participant3@gmail.com', 'C');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG04', 'Participant4', 'participant4@gmail.com', 'D');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG05', 'Participant5', 'participant5@gmail.com', 'E');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG06', 'Participant6', 'participant6@gmail.com', 'F');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG07', 'Participant7', 'participant7@gmail.com', 'G');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG08', 'Participant8', 'participant8@gmail.com', 'H');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG09', 'Participant9', 'participant9@gmail.com', 'I');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG10', 'Participant10', 'participant10@gmail.com', 'J');

INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG11', 'Participant1', 'participant1@gmail.com', 'A');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG12 ', 'Participant2', 'participant2@gmail.com', 'B');
UPDATE `eventor`.`participants` SET `College`='A' WHERE `Registration_Id`='REG03';
UPDATE `eventor`.`participants` SET `College`='A' WHERE `Registration_Id`='REG06';
UPDATE `eventor`.`participants` SET `College`='B' WHERE `Registration_Id`='REG08';
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG13', 'Participant11', 'participant11@gmail.com', 'A');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG14', 'Participant12', 'participant12@gmail.com', 'B');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG15', 'Participant3', 'participant3@gmail.com', 'A');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG16', 'Participant13', 'participant13@gmail.com', 'J');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG17', 'Participant14', 'participant1@gmail.com', 'G');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG18', 'Participant15', 'participant15@gmail.com', 'D');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG19', 'Participant4', 'participant4@gmail.com', 'D');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG20', 'Participant16', 'participant16@gmail.com', 'G');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG21', 'Participant17', 'participant17@gmail.com', 'E');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG22', 'Participant5', 'participant5@gmail.com', 'E');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG23', 'Participant6', 'participant6@gmail.com', 'A');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG24', 'Participant18', 'participant18@gmail.com', 'I');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG25', 'Participant19', 'participant19@gmail.com', 'I');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG26', 'Participant20', 'participant20@gmail.com', 'E');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG27', 'Participant7', 'participant7@gmail.com', 'G');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG28', 'Participant8', 'paricipant8@gmail.com', 'B');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG29', 'Participant9', 'participant9@gmail.com', 'I');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG30', 'Participant10', 'participant10@gmail.com', 'J');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG31', 'Participant11', 'participant11@gmail.com', 'A');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG32', 'Participant12', 'participant12@gmail.com', 'B');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG33', 'Participant13', 'participant13@gmail.com', 'J');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG34', 'Participant14', 'participant14@gmail.com', 'A');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG35', 'Participant15', 'participant15@gmail.com', 'D');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG36', 'Participant16', 'participant16@gmail.com', 'G');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG37', 'Participant1', 'participant1@gmail.com', 'A');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG38', 'Participant5', 'participant5@gmail.com', 'E');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG39', 'Participant8', 'participant8@gmail.com', 'B');
INSERT INTO `eventor`.`participants` (`Registration_Id`, `Participant_Name`, `Participant_Email_Id`, `College`) VALUES ('REG40', 'Participant10', 'participant10@gmail.com', 'J');

INSERT INTO `eventor`.`guests` (`Guest_Id`, `Guest_Name`, `Guest_Email_Id`, `Arrival_Time`, `Departure_Time`) VALUES ('G003', 'Guest3', 'guest3@gmail.com', '11:00:00.000000', '01:30:00.000000');
INSERT INTO `eventor`.`guests` (`Guest_Id`, `Guest_Name`, `Guest_Email_Id`, `Arrival_Time`, `Departure_Time`) VALUES ('G004', 'Guest4', 'guest4@gmail.com', '03:30:00.000000', '06:30:00.000000');
INSERT INTO `eventor`.`guests` (`Guest_Id`, `Guest_Name`, `Guest_Email_Id`, `Arrival_Time`, `Departure_Time`) VALUES ('G005', 'Guest5', 'guest5@gmail.com', '06:00:00.000000', '09:00:00.000000');
INSERT INTO `eventor`.`guests` (`Guest_Id`, `Guest_Name`, `Guest_Email_Id`, `Arrival_Time`, `Departure_Time`) VALUES ('G006', 'Guest6', 'guest6@gmail.com', '10:00:00.000000', '01:00:00.000000');
INSERT INTO `eventor`.`guests` (`Guest_Id`, `Guest_Name`, `Guest_Email_Id`, `Arrival_Time`, `Departure_Time`) VALUES ('G007', 'Guest7', 'guest7@gmail.com', '07:00:00.000000', '11:00:00.000000');
INSERT INTO `eventor`.`guests` (`Guest_Id`, `Guest_Name`, `Guest_Email_Id`, `Arrival_Time`, `Departure_Time`) VALUES ('G008', 'Guest8', 'guest8@gmail.com', '10:00:00.000000', '01:00:00.000000');
UPDATE `eventor`.`guests` SET `Arrival_Time`='07:00:00.000000', `Departure_Time`='11:00:00.000000' WHERE `Guest_Id`='G001';
UPDATE `eventor`.`guests` SET `Arrival_Time`='09:00:00.000000' WHERE `Guest_Id`='G002';

INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('1', 'DANC001', 'REG02');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('2', 'DEBA001', 'REG03');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('3', 'GRAF001', 'REG04');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('4', 'DJNI001', 'REG05');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('5', 'PAIN001', 'REG06');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('6', 'PHOT001', 'REG07');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('7', 'SING001', 'REG08');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('8', 'STOC001', 'REG09');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('9', 'TRAS001', 'REG10');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('10', 'TREA001', 'REG01');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('11', 'DANC001', 'REG37');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('12', 'DEBA001', 'REG28');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('13', 'GRAF001', 'REG39');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('14', 'DJNI001', 'REG30');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('15', 'PAIN001', 'REG40');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('16', 'PHOT001', 'REG20');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('17', 'SING001', 'REG11');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('18', 'STOC001', 'REG38');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('19', 'TRAS001', 'REG22');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('20', 'TREA001', 'REG36');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('21', 'DANC001', 'REG13');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('22', 'DANC001', 'REG14');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('23', 'DEBA001', 'REG31');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('24', 'TREA001', 'REG32');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('25', 'TRAS001', 'REG16');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('26', 'SING001', 'REG33');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('27', 'STOC001', 'REG34');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('28', 'DJNI001', 'REG17');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('29', 'GRAF001', 'REG18');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('30', 'PHOT001 ', 'REG35');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('31', 'DANC001', 'REG21');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('32', 'PHOT001', 'REG24');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('33', 'SING001', 'REG25');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('34', 'TRAS001', 'REG26');

INSERT INTO `eventor`.`relation_events_guests` (`Event_Id`, `Guest_Id`, `Sr_No`) VALUES ('DANC001', 'G001', '1');
INSERT INTO `eventor`.`relation_events_guests` (`Event_Id`, `Guest_Id`, `Sr_No`) VALUES ('DEBA001', 'G002', '2');
INSERT INTO `eventor`.`relation_events_guests` (`Event_Id`, `Guest_Id`, `Sr_No`) VALUES ('SING001', 'G003', '3');
INSERT INTO `eventor`.`relation_events_guests` (`Event_Id`, `Guest_Id`, `Sr_No`) VALUES ('GRAF001', 'G004', '4');
INSERT INTO `eventor`.`relation_events_guests` (`Event_Id`, `Guest_Id`, `Sr_No`) VALUES ('PHOT001', 'G005', '5');
INSERT INTO `eventor`.`relation_events_guests` (`Event_Id`, `Guest_Id`, `Sr_No`) VALUES ('TRAS001', 'G006', '6');
INSERT INTO `eventor`.`relation_events_guests` (`Event_Id`, `Guest_Id`, `Sr_No`) VALUES ('DANC001', 'G007', '7');
INSERT INTO `eventor`.`relation_events_guests` (`Event_Id`, `Guest_Id`, `Sr_No`) VALUES ('SING001', 'G008', '8');

UPDATE `eventor`.`participants` SET `College`='G' WHERE `Registration_Id`='REG34';

INSERT INTO `eventor`.`winner` (`Sr_No`, `Event_Id`, `Registration_Id`, `Position`) VALUES ('1', 'DANC001', 'REG02', '1');
INSERT INTO `eventor`.`winner` (`Sr_No`, `Event_Id`, `Registration_Id`, `Position`) VALUES ('2', 'DANC001', 'REG37', '2');
INSERT INTO `eventor`.`winner` (`Sr_No`, `Event_Id`, `Registration_Id`, `Position`) VALUES ('3', 'SING001', 'REG08', '1');
INSERT INTO `eventor`.`winner` (`Sr_No`, `Event_Id`, `Registration_Id`, `Position`) VALUES ('4', 'SING001', 'REG11', '2');

/*how many volunteers for a particular event*/
select COUNT(volunteers.Volunteer_Id) from event_coordinator
inner join relation_eventcoordinator_volunteer on event_coordinator.Event_Coordinator_Id = relation_eventcoordinator_volunteer.Event_Coordinator_Id
inner join volunteers on volunteers.Volunteer_Id = relation_eventcoordinator_volunteer.Volunteer_Id
inner join relation_event_eventcoordinator on relation_event_eventcoordinator.Event_Coordinator_Id = event_coordinator.Event_Coordinator_Id
inner join events on events.Event_Id = relation_event_eventcoordinator.Event_Id
where events.Event_Id = "DANC001";

/*Name the particiapants*/
select volunteers.Volunteer_Name from event_coordinator
inner join relation_eventcoordinator_volunteer on event_coordinator.Event_Coordinator_Id = relation_eventcoordinator_volunteer.Event_Coordinator_Id
inner join volunteers on volunteers.Volunteer_Id = relation_eventcoordinator_volunteer.Volunteer_Id
inner join relation_event_eventcoordinator on relation_event_eventcoordinator.Event_Coordinator_Id = event_coordinator.Event_Coordinator_Id
inner join events on events.Event_Id = relation_event_eventcoordinator.Event_Id
where events.Event_Id = "GRAF001";

/*how many participants for a aparticular event*/
select COUNT(Registration_Id) from relation_events_participants where Event_Id = "DANC001";

/*list the participants in a particular event*/
select Participant_Name from relation_events_participants inner join participants on participants.Registration_Id = relation_events_participants.Registration_Id
inner join events on events.Event_Id = relation_events_participants.Event_Id where events.Event_Id="SING001";

/*location of particular event*/
select Location from allocations where Event_Id = "SING001";

/*date and time of particular event*/
select Event_Name from events where Start_Time = "09:00:00.000000" and End_Time = "01:00:00.000000" and Start_Date = "2017-02-25" and End_Date = "2017-02-25"; 

/*total budget*/
select sum(Event_Budget) from resources;

/*budget for particular event*/
select Event_Budget from resources where Event_Id = "TRAS001";

/*event having budget less than 7000*/
select Event_Name from events where Event_Id in(select Event_Id from resources where Event_Budget < "7000" ); 

/*guest invited*/
select Guest_Name, Event_Name from guests,events, relation_events_guests where relation_events_guests.Guest_Id = guests.Guest_Id and relation_events_guests.Event_Id = events.Event_Id;

/*particulat events start time and end time and location*/
select Start_Time, End_Time, Location from events,allocations where events.Event_Id = allocations.Event_Id and events.Event_Id = "TREA001";

/*volunteers under particular event coordinator*/
select Volunteer_Name from relation_eventcoordinator_volunteer inner join volunteers on volunteers.Volunteer_Id = relation_eventcoordinator_volunteer.Volunteer_Id inner join event_coordinator on event_coordinator.Event_Coordinator_Id = relation_eventcoordinator_volunteer.Event_Coordinator_Id where event_coordinator.Event_Coordinator_Id = "EVC001" ;

/*Events under particular main event*/
select Event_Name from relation_event_mainevent inner join events on events.Event_Id = relation_event_mainevent.Event_Id inner join main_event on relation_event_mainevent.Main_Event_Id = main_event.Main_Event_Id where main_event.Main_Event_Id = "JA2017";

/*A particular event comes under which main event*/
select Main_Event_Name, Event_Name from main_event, events, relation_event_mainevent where main_event.Main_Event_Id = relation_event_mainevent.Main_Event_Id and events.Event_Id = relation_event_mainevent.Event_Id;

/*at a particular location which event coordinator is present*/
select Event_Coordinator_Name from events inner join relation_event_eventcoordinator on events.Event_Id = relation_event_eventcoordinator.Event_Id 
inner join event_coordinator on event_coordinator.Event_Coordinator_Id = relation_event_eventcoordinator.Event_Coordinator_Id
inner join allocations on allocations.Event_Id = events.Event_Id where location = "Garden Area";

/*winner of a particular events*/
select Participant_Name from participants,winner where participants.Registration_Id = winner.Registration_Id and Event_Id="DANC001";

/*Resources required for a particulat event*/ 
select Expense_Area from event_budget where Event_Id="CZAR001";

/*college of a particular participants*/
select distinct College from participants where Participant_Name = "Participant1";

/*list of participants having a particular college*/
select distinct Participant_Name from participants where College = "D";

/*Events on a particular date*/
select Event_Name from events where Start_Date = "2017-02-25";

/*guest is looked after which event coordinator*/
select Event_Coordinator_Name, Guest_Name from event_coordinator,guests,relation_event_eventcoordinator,relation_events_guests where relation_events_guests.Event_Id = relation_event_eventcoordinator.Event_Id and relation_event_eventcoordinator.Event_Coordinator_Id = event_coordinator.Event_Coordinator_Id and relation_events_guests.Guest_Id = guests.Guest_Id;

/*Participants participanting in which events*/
select Event_Name,Participant_Name from relation_events_participants inner join events on events.Event_Id = relation_events_participants.Event_Id inner join participants on participants.Registration_Id = relation_events_participants.Registration_Id where Participant_Name = "Participant1";

/*Participant participanting in how many events*/
select count(events.Event_Id) from relation_events_participants inner join events on events.Event_Id = relation_events_participants.Event_Id inner join participants on participants.Registration_Id = relation_events_participants.Registration_Id where Participant_Name = "Participant1";

/*Participants for a particular event*/
select Event_Name,COUNT(participants.Registration_Id) from relation_events_participants inner join participants on participants.Registration_Id = relation_events_participants.Registration_Id inner join events on events.Event_Id = relation_events_participants.Event_Id group by(events.Event_Id);
/*Particating in a particular events*/
select Event_Name,COUNT(participants.Registration_Id) from relation_events_participants inner join participants on participants.Registration_Id = relation_events_participants.Registration_Id inner join events on events.Event_Id = relation_events_participants.Event_Id where events.Event_Id = "GRAF001";

/*total number of participants*/
select distinct COUNT(participants.Registration_Id) from relation_events_participants inner join participants on participants.Registration_Id = relation_events_participants.Registration_Id inner join events on events.Event_Id = relation_events_participants.Event_Id;

/*Total number of events under main events*/
select COUNT(events.Event_Id) from relation_event_mainevent inner join events on events.Event_Id = relation_event_mainevent.Event_Id inner join main_event on main_event.Main_Event_Id = relation_event_mainevent.Main_Event_Id;

/*Event having particular specifications*/
select events.Event_Name from events 
inner join relation_event_mainevent on relation_event_mainevent.Event_Id = events.Event_Id 
inner join main_event on relation_event_mainevent.Main_Event_Id = main_event.Main_Event_Id 
inner join relation_event_eventcoordinator on relation_event_eventcoordinator.Event_Id = events.Event_Id
inner join event_coordinator on event_coordinator.Event_Coordinator_Id = relation_event_eventcoordinator.Event_Coordinator_Id
inner join allocations on allocations.Event_Id = events.Event_Id
where events.Start_Date="2017-02-25" and events.End_Date="2017-02-25" and events.Start_Time="09:00:00.000000" and events.End_Time="01:00:00.000000" and event_coordinator.Event_Coordinator_Id="EVC005" and allocations.Location ="Airport";

/*store procedure of location*/
CREATE PROCEDURE `event_location`(IN loc varchar(45))
Select Event_Name,Location from events inner join  allocations on events.Event_Id = allocations.Event_Id
where Location = loc;

call event_location("Courtyard");

#number of prizes an individual student won
select Participant_Name,count(*) as Number_of_events from participants where Registration_Id IN(select Registration_Id from winner) group by Participant_Name;

#procedure to see rank wise winners
CREATE PROCEDURE `winner_rankwise` (IN var1 INT)
SELECT Registration_Id FROM winner where Position = var1;

call winner_rankwise(1);

#event wise participants
CREATE PROCEDURE `event_participants` (IN event_name varchar(45))
select Event_Name,Participant_Name from events,relation_events_participants,participants 
WHERE relation_events_participants.Event_Id = events.Event_Id 
and participants.Registration_Id = relation_events_participants.Registration_Id and 
events.Event_Name = event_name;

call event_participants("Graffiti");

/*participants college*/

create procedure `parti_college` (IN col varchar(45))
select distinct Participant_Name from participants where College = col;

call parti_college("D");

/*from a event id displaying its all events*/
select main_event.Main_Event_Name,events.Event_Name,events.Start_Date,events.End_Date,events.Start_Time,
events.End_Time,event_coordinator.Event_Coordinator_Name,allocations.Location,resources.Event_Budget,guests.Guest_Name from events 
inner join relation_event_mainevent on relation_event_mainevent.Event_Id = events.Event_Id 
inner join main_event on relation_event_mainevent.Main_Event_Id = main_event.Main_Event_Id 
inner join relation_event_eventcoordinator on relation_event_eventcoordinator.Event_Id = events.Event_Id
inner join event_coordinator on event_coordinator.Event_Coordinator_Id = relation_event_eventcoordinator.Event_Coordinator_Id
inner join allocations on allocations.Event_Id = events.Event_Id
inner join resources on resources.Event_Id = events.Event_Id
inner join relation_events_guests on relation_events_guests.Event_Id = events.Event_Id
inner join guests on guests.Guest_Id = relation_events_guests.Guest_Id
where events.Event_Id="GRAF001";

/*location empty at a particular time slot*/
select distinct Location from allocations where location not in(
select Location as Loc from allocations 
inner join events on events.Event_Id = allocations.Event_Id 
where events.Start_Time="11:00:00.000000" and events.End_Time="01:30.000000" and events.Start_Date="2017-02-24");

/*time table*/
select main_event.Main_Event_Name,events.Event_Name,events.Start_Date,events.End_Date,events.Start_Time,events.End_Time,
event_coordinator.Event_Coordinator_Name,allocations.Location,resources.Event_Budget,guests.Guest_Name from events 
left join relation_event_mainevent on relation_event_mainevent.Event_Id = events.Event_Id 
left join main_event on relation_event_mainevent.Main_Event_Id = main_event.Main_Event_Id 
left join relation_event_eventcoordinator on relation_event_eventcoordinator.Event_Id = events.Event_Id
left join event_coordinator on event_coordinator.Event_Coordinator_Id = relation_event_eventcoordinator.Event_Coordinator_Id
left join allocations on allocations.Event_Id = events.Event_Id
left join resources on resources.Event_Id = events.Event_Id
left join relation_events_guests on relation_events_guests.Event_Id = events.Event_Id
left join guests on guests.Guest_Id = relation_events_guests.Guest_Id;

/*store procedure5*/
CREATE PROCEDURE `new_procedure2`(OUT name varchar(20),IN ID varchar(10))
select Participant_Name into name from participants where Registration_Id = ID;

set @ID = 'REG14';	
call `eventor`.`new_procedure2`(@NAME, @ID);
select @NAME;

/*winner having 2nd position of a particular event*/
select Participant_Name from participants inner join winner on winner.Registration_Id = participants.Registration_Id where winner.Event_Id="DANC001" and position = "2";

/*guest with many specifications*/
select guests.Guest_Name from events 
inner join relation_event_mainevent on relation_event_mainevent.Event_Id = events.Event_Id 
inner join main_event on relation_event_mainevent.Main_Event_Id = main_event.Main_Event_Id 
inner join relation_event_eventcoordinator on relation_event_eventcoordinator.Event_Id = events.Event_Id
inner join event_coordinator on event_coordinator.Event_Coordinator_Id = relation_event_eventcoordinator.Event_Coordinator_Id
inner join allocations on allocations.Event_Id = events.Event_Id
inner join relation_events_guests on relation_events_guests.Event_Id = events.Event_Id
inner join guests on guests.Guest_Id = relation_events_guests.Guest_Id
where events.Start_Time="11:00:00.000000" and events.End_Time="01:30:00.000000" and allocations.location="Courtyard"and event_coordinator.Event_Coordinator_Id="EVC007";

/*displaying an event name with given conditions*/
select events.Event_Name from events 
inner join relation_event_mainevent on relation_event_mainevent.Event_Id = events.Event_Id 
inner join main_event on relation_event_mainevent.Main_Event_Id = main_event.Main_Event_Id 
inner join relation_event_eventcoordinator on relation_event_eventcoordinator.Event_Id = events.Event_Id
inner join event_coordinator on event_coordinator.Event_Coordinator_Id = relation_event_eventcoordinator.Event_Coordinator_Id
inner join resources on resources.Event_Id = events.Event_Id
inner join allocations on allocations.Event_Id = events.Event_Id
inner join relation_events_guests on relation_events_guests.Event_Id = events.Event_Id
inner join guests on guests.Guest_Id = relation_events_guests.Guest_Id
where events.Start_Time="10:00:00.000000" and events.End_Time="01:00:00.000000" and allocations.location="Courtyard"and event_coordinator.Event_Coordinator_Id="EVC012"and guests.Guest_Id="G006" and Event_Budget="2000";

select Event_Name,Participant_Name from relation_events_participants inner join events on events.Event_Id = relation_events_participants.Event_Id inner join participants on participants.Registration_Id = relation_events_participants.Registration_Id where Participant_Name = "Participant1";
select count(events.Event_Id) from relation_events_participants inner join events on events.Event_Id = relation_events_participants.Event_Id inner join participants on participants.Registration_Id = relation_events_participants.Registration_Id where Participant_Name = "Participant15";

/*Trigger update participant name*/
CREATE TABLE participants_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Registration_Id varchar(50) NOT NULL,
    Participant_Name VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

DELIMITER $$
CREATE TRIGGER participants_update 
    BEFORE UPDATE ON participants
    FOR EACH ROW 
BEGIN
    INSERT INTO participants_audit
    SET action = 'update',
     Registration_Id = OLD.registration_Id,
        Participant_Name = OLD.Participant_Name,
        changedat = NOW();
END$$
DELIMITER ;
update participants set participants.Participant_Name = "Participant003" where participants.Registration_Id="REG03";
select * from participants_audit;

/*Delete Trigger*/
CREATE TABLE delete_events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_Id varchar(50) NOT NULL,
    event_Name VARCHAR(50) NOT NULL,
    start_Date date,
    end_Date date,
    start_Time time,
    end_Time time,
    deletedate DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);
DELIMITER $$
CREATE TRIGGER events_delete 
    AFTER DELETE ON events
    FOR EACH ROW 
BEGIN
    INSERT INTO delete_events
    SET action = 'delete',
     event_Id = OLD.Event_Id,
        event_Name = OLD.Event_Name,
        start_Date = OLD.Start_Date,
        end_Date = OLD.End_Date,
        start_Time = OLD.Start_Time,
        end_Time = OLD.End_Time,
        deletedate = NOW();
END$$
DELIMITER ;
delete from events where Event_Id="TP001";
select * from delete_events;
drop trigger events_delete;
drop trigger participants_update;
show triggers;
insert into events value('TP001','Time Pass','2017-02-26','2017-02-26','08:00:00.000000','10:00:00.000000');
insert into participants values('REG42','Participant1','participant1@gmail.com','A');
insert into participants values('REG43','Participant1','participant1@gmail.com','A');


INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('1', 'DANC001', '0');
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('2', 'GRAF001', '0');

UPDATE event_audit1 set event_audit1.number_of_participation = event_audit1.number_of_participation + 1 where event_audit1.event_Id = 'DANC001';
/*trigger 3*/
CREATE TABLE event_audit1 (
    id INT not null,
    event_Id varchar(50) primary key,
	number_of_participation INT NOT NULL);

DELIMITER $$
CREATE TRIGGER add_Parti 
    AFTER INSERT ON relation_events_participants
    FOR EACH ROW 
BEGIN
    UPDATE event_audit1 set event_audit1.number_of_participation = event_audit1.number_of_participation  + 1
    where event_audit1.Event_Id = NEW.event_Id;
END$$
DELIMITER ;

INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('38', 'DANC001', 'REG42');
INSERT INTO `eventor`.`relation_events_participants` (`Sr_No`, `Event_Id`, `Registration_Id`) VALUES ('39', 'SING001', 'REG43');

show triggers;
drop trigger add_Parti;
/*EVENT_AUDIT*/
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('3', 'SING001', '0');
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('4', 'TRAS001', '0');
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('5', 'TREA001', '0');
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('6', 'PHOT001', '0');
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('7', 'CZAR001', '0');
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('8', 'CZAR002', '0');
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('9', 'CZAR003', '0');
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('10', 'DEBA001', '0');
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('11', 'STOC001', '0');
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('12', 'DJNI001', '0');
INSERT INTO `eventor`.`event_audit1` (`id`, `event_Id`, `number_of_participation`) VALUES ('13', 'PAIN001', '0');

select * from event_audit1;


