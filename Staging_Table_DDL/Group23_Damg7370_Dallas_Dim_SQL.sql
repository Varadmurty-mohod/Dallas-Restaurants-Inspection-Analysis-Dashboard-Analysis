CREATE TABLE `Dim_Dallas_Geography`  (
  `Geography_SK` int NOT NULL,
  `StreetNumber` varchar(254) NULL,
  `StreetName` varchar(20) NULL,
  `Zipcode` char(10) NULL,
  `StreetDirection` int NULL,
  `Street Type` varchar(50) NULL,
  `StreetUnit` int NULL,
  `StreetAddress` char(6) NULL,
  `Latitude` char(18) NULL,
  `Longitude` char(18) NULL,
  `Location` varchar(50) NULL,
  `DI_CreateDate` datetime NULL,
  `DI_WorkflowDirectory` varchar(255) NULL,
  `DI_WorkflowFileName` varchar(255) NULL,
    NULL,
  PRIMARY KEY (`Geography_SK`)
);

CREATE TABLE `Dim_Dallas_InspectionType`  (
  `InspectionType_SK` int NOT NULL,
  `Inspection_Type` varchar(254) NULL,
  `DI_CreateDate` datetime NULL,
  `DI_WorkflowDirectory` varchar(255) NULL,
  `DI_WorkflowFileName` varchar(255) NULL,
  PRIMARY KEY (`InspectionType_SK`)
);

CREATE TABLE `Dim_Dallas_Restaurant`  (
  `RestaurantSK` int NOT NULL,
  `Name` varchar(254) NULL,
  `DI_CreateDate` datetime NULL,
  `DI_WorkflowDirectory` varchar(255) NULL,
  `DI_WorkflowFileName` varchar(255) NULL,
  PRIMARY KEY (`RestaurantSK`)
);

CREATE TABLE `Dim_Date`  (
  `Date_sk` int NOT NULL,
  `Inspection_Date` date NULL,
  `Record_Date` date NULL,
  `Grade_Date` date NULL,
  PRIMARY KEY (`Date_sk`)
);

CREATE TABLE `Fact_Dallas_inspection`  (
  `InspectionSK` int NOT NULL,
  `InspectionTypeSK` int NULL,
  `RestaurantSK` int NULL,
  `GeographySK` int NULL,
  `InspectionDate` date NULL,
  `InspectionFinancialYear` date NULL,
  `InspectionScore` int NULL,
  `DI_CreateDate` int NULL,
  `DI_WorkflowDirectory` varchar(255) NULL,
  `DI_WorkflowFileName` varchar(255) NULL,
  PRIMARY KEY (`InspectionSK`)
);

CREATE TABLE `Fact_Dallas_Violation`  (
  `InspectionViolationSK` int NOT NULL,
  `InspectionSK` int NULL,
  `ViolationDetail` varchar(1000) NULL,
  `ViolationDescription` varchar(255) NULL,
  `ViolationMemo` varchar(255) NULL,
  `ViolationPoints` varchar(255) NULL,
  `DI_CreateDate` datetime NULL,
  `DI_WorkflowDirectory` varchar(255) NULL,
  `DI_WorkflowFileName` varchar(255) NULL,
  PRIMARY KEY (`InspectionViolationSK`)
);

ALTER TABLE `Dim_Dallas_Geography` MODIFY COLUMN ``  NULL AFTER `DI_WorkflowFileName`;
ALTER TABLE `Dim_Date` ADD CONSTRAINT `fk_Dim_Date_Fact Table_1` FOREIGN KEY (`Date_sk`) REFERENCES `Fact_Dallas_inspection` (`date_fk`);
ALTER TABLE `Fact_Dallas_inspection` ADD CONSTRAINT `Restaurant FK` FOREIGN KEY (`RestaurantSK`) REFERENCES `Dim_Dallas_Restaurant` (`RestaurantSK`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `Fact_Dallas_inspection` ADD CONSTRAINT `Inspection FK` FOREIGN KEY (`InspectionTypeSK`) REFERENCES `Dim_Dallas_InspectionType` (`InspectionType_SK`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `Fact_Dallas_inspection` ADD CONSTRAINT `Grade FK` FOREIGN KEY (`Grade_SK`) REFERENCES `Dim_Nyc_Grade` (`GradeSK`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `Fact_Dallas_inspection` ADD CONSTRAINT `Geography FK` FOREIGN KEY (`GeographySK`) REFERENCES `Dim_Dallas_Geography` (`Geography_SK`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `Fact_Dallas_Violation` ADD CONSTRAINT `InspectionSK` FOREIGN KEY (`InspectionSK`) REFERENCES `Fact_Dallas_inspection` (`InspectionSK`) ON DELETE CASCADE ON UPDATE CASCADE;

