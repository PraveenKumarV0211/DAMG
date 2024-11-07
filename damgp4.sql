-- Set the database to single-user mode to force disconnections
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'DAMG_ASSIGNMENT_GROUP_16')
BEGIN
    ALTER DATABASE DAMG_ASSIGNMENT_GROUP_16 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DAMG_ASSIGNMENT_GROUP_16;
END;

-- Create the database
CREATE DATABASE DAMG_ASSIGNMENT_GROUP_16;
GO

-- Use the database
USE DAMG_ASSIGNMENT_GROUP_16;
GO

-- Drop primary reference tables if they exist
DROP TABLE IF EXISTS ServiceProvider;
DROP TABLE IF EXISTS Insurance;
DROP TABLE IF EXISTS InsuranceCompany;
DROP TABLE IF EXISTS DEALERSHIP;
DROP TABLE IF EXISTS USERS;
DROP TABLE IF EXISTS IOT_DEVICE;

DROP TABLE IF EXISTS RoadsideIncident;
DROP TABLE IF EXISTS AccidentIncident;
DROP TABLE IF EXISTS ServiceHistory;

-- Drop tables that other tables depend on
DROP TABLE IF EXISTS Incident;
DROP TABLE IF EXISTS VEHICLE;
DROP TABLE IF EXISTS SIM;
DROP TABLE IF EXISTS LOCATION;

-- SIM table
CREATE TABLE SIM (
    IMEI VARCHAR(20),
    NetworkProvider VARCHAR(20) NOT NULL,
    IMSI VARCHAR(20) NOT NULL,
    ActivationStatus VARCHAR(20) CHECK (ActivationStatus IN ('Active', 'InActive', 'In Progress')),
    DialNumber VARCHAR(20) NOT NULL,
    ActivationDate DATE,
    CONSTRAINT PK PRIMARY KEY (IMEI)
);
ALTER TABLE SIM ADD CONSTRAINT UQ_IMSI UNIQUE (IMSI);
ALTER TABLE SIM ADD CONSTRAINT UQ_DialNumber UNIQUE (DialNumber);

-- IOT_DEVICE table
CREATE TABLE IOT_DEVICE (
    DeviceID VARCHAR(20),
    IMEI VARCHAR(20),
    Manufacturer VARCHAR(20) NOT NULL,
    InstalationDate DATETIME NOT NULL,
    [Location] INT,
    HardwareVersion FLOAT,
    Speed FLOAT,
    Temperature FLOAT,
    FuelRange FLOAT,
    CONSTRAINT PK1 PRIMARY KEY (DeviceID),
    CONSTRAINT FK1 FOREIGN KEY (IMEI) REFERENCES SIM(IMEI)
);

-- LOCATION table
CREATE TABLE LOCATION (
    LocationID INT IDENTITY(1,1) UNIQUE,
    DeviceID VARCHAR(20),
    Latitude DECIMAL(9, 6),
    Longitude DECIMAL(9, 6),
    Location_TimeStamp DATETIME NOT NULL,
    CONSTRAINT pk_device PRIMARY KEY (DeviceID, Location_TimeStamp),
    CONSTRAINT fk_device FOREIGN KEY (DeviceID) REFERENCES IOT_DEVICE(DeviceID)
);

-- InsuranceCompany table
CREATE TABLE InsuranceCompany (
    InsuranceProviderID INT PRIMARY KEY,
    ProviderName VARCHAR(100) NOT NULL,
    Street VARCHAR(100),
    City VARCHAR(50),
    [State] VARCHAR(50),
    ZipCode VARCHAR(10) NOT NULL,
    ContactNumber VARCHAR(15) NOT NULL
);

-- Insurance table
CREATE TABLE Insurance (
    InsuranceNumber INT PRIMARY KEY,
    PolicyNumber VARCHAR(50) NOT NULL,
    [Status] VARCHAR(20),
    StartDate DATE,
    EndDate DATE,
    InsuranceProviderID INT,
    FOREIGN KEY (InsuranceProviderID) REFERENCES InsuranceCompany(InsuranceProviderID)
);

-- USERS table
CREATE TABLE USERS (
    UserID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    DOB DATE,
    DriverLicenseNumber VARCHAR(20),
    PhoneNumber VARCHAR(15)
);

-- DEALERSHIP table
CREATE TABLE DEALERSHIP (
    DealerID INT NOT NULL PRIMARY KEY,
    DealerName VARCHAR(20) NOT NULL,
    Street VARCHAR(30),
    City VARCHAR(30),
    [State] VARCHAR(50),
    ZipCode VARCHAR(10),
    ContactNumber VARCHAR(15)
);

-- VEHICLE table
CREATE TABLE VEHICLE (
    VIN VARCHAR(17) NOT NULL PRIMARY KEY,
    DeviceID VARCHAR(20) NOT NULL,
    InsuranceNumber INT NOT NULL,
    DealerID INT NOT NULL,
    UserID INT NOT NULL,
    LicenseNumber VARCHAR(15),
    Model VARCHAR(50),
    [Year] INT,
    Colour VARCHAR(20),
    FuelType VARCHAR(20),
    CONSTRAINT VEHICLE_DAELER_FK FOREIGN KEY (DealerID) REFERENCES DEALERSHIP(DealerID),
    CONSTRAINT VEHICLE_USER_FK FOREIGN KEY (UserID) REFERENCES USERS(UserID),
    CONSTRAINT VEHICLE_IOTDEVICE_FK FOREIGN KEY (DeviceID) REFERENCES IOT_DEVICE(DeviceID),
    CONSTRAINT VEHICLE_INSURANCE_FK FOREIGN KEY (InsuranceNumber) REFERENCES Insurance(InsuranceNumber)
);

-- ServiceProvider table
CREATE TABLE ServiceProvider (
    ServiceProviderID INT PRIMARY KEY,
    ProviderName VARCHAR(100) NOT NULL,
    Street VARCHAR(100),
    City VARCHAR(50),
    [State] VARCHAR(50),
    ZipCode VARCHAR(10),
    PhoneNumber VARCHAR(15)
);

-- ServiceHistory table
CREATE TABLE ServiceHistory (
    ServiceID INT PRIMARY KEY,
    UserID INT NOT NULL,
    VIN VARCHAR(17) NOT NULL,
    ServiceProviderID INT,
    ServiceDate DATE NOT NULL,
    Cost DECIMAL(10, 2),
    [Description] TEXT,
    FOREIGN KEY (UserID) REFERENCES USERS(UserID),
    FOREIGN KEY (VIN) REFERENCES VEHICLE(VIN),
    FOREIGN KEY (ServiceProviderID) REFERENCES ServiceProvider(ServiceProviderID)
);

-- Incident table
CREATE TABLE Incident (
    IncidentID INT PRIMARY KEY IDENTITY(1,1),
    LocationID INT NOT NULL,
    AccidentType NVARCHAR(20) NOT NULL CHECK (AccidentType IN ('Roadside', 'Accident')),
    IncidentDate DATE NOT NULL,
    [Description] NVARCHAR(255),
    AssistanceArrivalTime TIME,
    [Status] NVARCHAR(50) CHECK (Status IN ('Initiated', 'Completed', 'In Progress')),
    SeverityLevel INT CHECK (SeverityLevel BETWEEN 1 AND 5),
    VIN VARCHAR(17) NOT NULL,
    FOREIGN KEY (LocationID) REFERENCES LOCATION(LocationID)
);

-- RoadsideIncident table
CREATE TABLE RoadsideIncident (
    RIncidentID INT PRIMARY KEY,
    AssistanceType NVARCHAR(50) NOT NULL,
    ServiceCompletionTime TIME,
    ServiceRating INT CHECK (ServiceRating BETWEEN 1 AND 5),
    FOREIGN KEY (RIncidentID) REFERENCES Incident(IncidentID)
);

-- AccidentIncident table
CREATE TABLE AccidentIncident (
    AIncidentID INT PRIMARY KEY,
    CollisionType NVARCHAR(50) NOT NULL,
    PoliceReportNumber NVARCHAR(50) UNIQUE,
    Fatalities INT,
    Cause NVARCHAR(255),
    FOREIGN KEY (AIncidentID) REFERENCES Incident(IncidentID)
);
