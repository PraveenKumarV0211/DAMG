use DAMG_ASSIGNMENT_GROUP_16
GO

--INSERT INTO SIM
INSERT into SIM values ('4321567891','T Mobile','0987651111','In Progress','9894465024','2024-01-01');
INSERT INTO SIM VALUES ('5432167892', 'Verizon', '0987652222', 'Active', '9895566035', '2024-02-01');
INSERT INTO SIM VALUES ('6543217893', 'AT&T', '0987653333', 'InActive', '9896667046', '2024-03-01');
INSERT INTO SIM VALUES ('7654321894', 'Sprint', '0987654444', 'Active', '9897768057', '2024-04-01');
INSERT INTO SIM VALUES ('8765432195', 'Vodafone', '0987655555', 'In Progress', '9898869068', '2024-05-01'),
('8765432194', 'T Mobile', '0987651112', 'Active', '9894461124', '2024-01-01'),
('6782167892', 'Verizon', '0987652332', 'InActive', '9895511035', '2024-02-15'),
('8763217893', 'AT&T', '0987653300', 'Active', '9896667116', '2024-03-10'),
('6784321894', 'Sprint', '0987651144', 'In Progress', '6797768057', '2024-04-05'),
('8935432195', 'Vodafone', '0987115555', 'In Progress', '9228869068', '2024-05-01');

--INSERT INTO IOT DEVICE
INSERT INTO IOT_DEVICE values('12345','4321567891','DeviceCorp','2024-01-01 09:30:00', 1, 1.0, 60.5, 22.5, 300.0)
INSERT INTO IOT_DEVICE VALUES ('23456', '5432167892', 'TechSystems', '2024-02-15 09:10:00', 2, 1.1, 55.3, 21.0, 250.0);
INSERT INTO IOT_DEVICE VALUES ('34567', '6543217893', 'Innovatech', '2024-03-10 10:45:00', 3, 1.2, 50.1, 23.8, 280.0);
INSERT INTO IOT_DEVICE VALUES ('45678', '7654321894', 'AutoWorks', '2024-04-05 10:45:10', 4, 1.3, 65.0, 20.5, 310.0);
INSERT INTO IOT_DEVICE VALUES ('56789', '8765432195', 'SmartDevices', '2024-05-20 10:55:00', 5, 1.4, 70.2, 25.0, 320.0);
insert into IOT_DEVICE values ('67890', '8765432194', 'DeviceCorp', '2024-06-18 14:00:00', 6, 1.5, 58.5, 22.0, 290.0),
('78901', '6782167892', 'TechSystems', '2024-07-30 17:00:00', 7, 1.6, 62.3, 24.1, 305.0),
('89012', '8763217893', 'Innovatech', '2024-08-25 19:10:00', 8, 1.7, 67.4, 21.8, 315.0),
('90123', '6784321894', 'AutoWorks', '2024-09-12 11:10:00', 9, 1.8, 64.0, 23.5, 325.0),
('01234', '8935432195', 'SmartDevices', '2024-10-05 11:11:00', 10, 1.9, 61.5, 26.0, 330.0);

--INSERT INTO LOCATION
INSERT into LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)values ('12345',40.712776,40.712776,'2024-11-03 10:53:00');
INSERT into LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)values ('12345',41.712776,-71.712776,'2024-11-04 09:57:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '23456', 40.715000, -74.010000, '2024-11-03 11:30:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '23456', 40.718000, -74.015000, '2024-11-03 12:00:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '23456', 41.878113, -87.629799, '2024-11-04 08:45:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '23456', 41.882000, -87.630000, '2024-11-04 09:00:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '23456', 41.885000, -87.635000, '2024-11-04 09:20:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '34567', 34.052235, -118.243683, '2024-11-05 10:30:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '34567', 34.055000, -118.250000, '2024-11-05 10:50:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '34567', 34.060000, -118.255000, '2024-11-05 11:10:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ('45678', 37.774929, -122.419418, '2024-11-06 13:25:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '45678', 37.778000, -122.424000, '2024-11-06 13:45:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '45678', 37.780000, -122.430000, '2024-11-06 14:05:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '56789', 47.606209, -122.332069, '2024-11-07 15:30:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '56789', 47.610000, -122.338000, '2024-11-07 15:50:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '56789', 47.615000, -122.342000, '2024-11-07 16:10:00');
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp)VALUES ( '56789', 29.770000, -95.380000, '2024-11-08 18:05:00');

--INSERT INTO INSURANCECOMPANY
INSERT INTO InsuranceCompany VALUES 
(1, 'HealthGuard Insurance', '123 Elm St', 'New York', 'NY', '10001', '212-555-1234'), 
(2, 'SafeLife Assurance', '456 Maple Ave', 'Los Angeles', 'CA', '90001', '310-555-5678'),
(3, 'PrimeCare Coverage', '789 Oak Blvd', 'Chicago', 'IL', '60601', '312-555-9012'),
(4, 'SecureHealth', '321 Pine Rd', 'Houston', 'TX', '77001', '713-555-3456'),
(5, 'WellnessPlus', '654 Cedar Ln', 'Miami', 'FL', '33101', '305-555-7890'),
(6, 'LifeGuard Insurance', '234 Oak St', 'San Francisco', 'CA', '94102', '415-555-1234'),
(7, 'Trusted Health', '789 Pine St', 'Austin', 'TX', '73301', '512-555-6789'),
(8, 'FamilyCare Insurance', '345 Maple Blvd', 'Seattle', 'WA', '98101', '206-555-4321'),
(9, 'Guardian Health', '101 Cedar Ave', 'Denver', 'CO', '80201', '303-555-8765'),
(10, 'SecureLife', '202 Elm St', 'Boston', 'MA', '02101', '617-555-3456');

--INSERT INTO INSURANCE
INSERT INTO Insurance (InsuranceNumber, PolicyNumber, [Status], StartDate, EndDate, InsuranceProviderID) VALUES 
(1001, 'POL12345', 'Active', '2024-01-01', '2025-01-01', 1),
(1002, 'POL67890', 'Expired', '2023-01-01', '2024-01-01', 2),
(1003, 'POL54321', 'Active', '2024-06-15', '2025-06-15', 3),
(1004, 'POL09876', 'Pending', '2024-05-01', '2025-05-01', 4),
(1005, 'POL13579', 'Cancelled', '2022-01-01', '2023-01-01', 5),
(1006, 'POL24680', 'Active', '2024-02-01', '2025-02-01', 6),
(1007, 'POL11223', 'Pending', '2024-03-01', '2025-03-01', 7),
(1008, 'POL33445', 'Expired', '2023-05-15', '2024-05-15', 8),
(1009, 'POL55667', 'Active', '2024-07-01', '2025-07-01', 9),
(1010, 'POL77889', 'Cancelled', '2022-09-01', '2023-09-01', 10);

--INSERT INTO USERS
INSERT INTO USERS (Name, DOB, DriverLicenseNumber, PhoneNumber) VALUES 
( 'John Doe', '1985-07-12', 'D12345678', '555-123-4567'),
( 'Jane Smith', '1990-03-22', 'S98765432', '555-234-5678'),
( 'Alice Johnson', '1975-11-05', 'J45678901', '555-345-6789'),
( 'Bob Brown', '1988-09-16', 'B87654321', '555-456-7890'),
( 'Carol White', '1995-05-30', 'W13579246', '555-567-8901'),
( 'David Miller', '1982-04-10', 'M67890123', '555-678-9012'),
( 'Emma Wilson', '1992-08-14', 'W78901234', '555-789-0123'),
( 'Olivia Brown', '1978-01-25', 'B89012345', '555-890-1234'),
( 'Liam Davis', '1987-11-02', 'D90123456', '555-901-2345'),
( 'Sophia Taylor', '1993-06-18', 'T01234567', '555-012-3456')

--INSERT INTO DEALERSHIP
INSERT INTO DEALERSHIP (DealerID, DealerName, Street, City, [State], ZipCode, ContactNumber)VALUES 
(1, 'AutoHub', '123 Main St', 'San Francisco', 'CA', '94103', '415-555-1234'),
(2, 'Prime Motors', '456 Market Ave', 'Los Angeles', 'CA', '90001', '213-555-5678'),
(3, 'DriveEasy', '789 Broadway', 'New York', 'NY', '10001', '212-555-7890'),
(4, 'Luxury Rides', '321 Fifth Ave', 'Chicago', 'IL', '60601', '312-555-3456'),
(5, 'Best Autos', '654 Lake St', 'Miami', 'FL', '33101', '305-555-4567'),
(6, 'Quality Cars', '789 King St', 'Seattle', 'WA', '98101', '206-555-6789'),
(7, 'EcoDrive', '234 Queen Rd', 'Austin', 'TX', '73301', '512-555-7890'),
(8, 'Urban Motors', '890 Sunset Blvd', 'Las Vegas', 'NV', '89101', '702-555-1234'),
(9, 'Elite Autos', '567 Grand Ave', 'Denver', 'CO', '80201', '303-555-2345'),
(10, 'Reliable Wheels', '123 Elm St', 'Boston', 'MA', '02101', '617-555-3456');

--INSERT INTO VEHICLE
INSERT INTO VEHICLE (VIN, DeviceID, InsuranceNumber, DealerID, UserID, LicenseNumber, Model, [Year], Colour, FuelType)
VALUES ('1HGCM82633A123456', '12345', 1001, 1, 1, 'ABC123', 'Honda Accord', 2023, 'Black', 'Gasoline');
INSERT INTO VEHICLE (VIN, DeviceID, InsuranceNumber, DealerID, UserID, LicenseNumber, Model, [Year], Colour, FuelType)
VALUES 
    ('1HGCM82633A654321', '23456', 1002, 2, 2, 'XYZ789', 'Toyota Camry', 2022, 'White', 'Diesel'),
    ('1HGCM82633A789012', '34567', 1003, 3, 3, 'LMN456', 'Ford Fusion', 2021, 'Blue', 'Hybrid'),
    ('1HGCM82633A345678', '45678', 1004, 4, 4, 'QRS123', 'Tesla Model S', 2024, 'Red', 'Electric'),
    ('1HGCM82633A876543', '56789', 1005, 5, 5, 'TUV789', 'Chevrolet Bolt', 2023, 'Green', 'Electric'),
    ('1HGCM82633A912345', '67890', 1006, 6, 6, 'JKL890', 'Nissan Altima', 2022, 'Silver', 'Gasoline'),
    ('2HGCM82633A456789', '78901', 1007, 7, 7, 'MNO321', 'Hyundai Sonata', 2021, 'Gray', 'Hybrid'),
    ('3HGCM82633A567890', '89012', 1008, 8, 8, 'PQR678', 'BMW 3 Series', 2024, 'Black', 'Diesel'),
    ('4HGCM82633A678901', '90123', 1009, 9, 9, 'STU234', 'Audi A4', 2023, 'Blue', 'Gasoline'),
    ('5HGCM82633A789012', '01234', 1010, 10, 10, 'VWX567', 'Mercedes C-Class', 2024, 'White', 'Gasoline');


--INSERT INTO SERVICE PROVIDER
INSERT INTO ServiceProvider (ServiceProviderID, ProviderName, Street, City, [State], ZipCode, PhoneNumber)
VALUES 
(1, 'AutoFixers', '123 Mechanic St', 'Los Angeles', 'CA', '90001', '310-555-1234'),
(2, 'QuickRepair', '456 Garage Ave', 'San Francisco', 'CA', '94103', '415-555-5678'),
(3, 'Speedy Service', '789 Maintenance Blvd', 'New York', 'NY', '10001', '212-555-7890'),
(4, 'Reliable Mechanics', '321 Repair Rd', 'Chicago', 'IL', '60601', '312-555-3456'),
(5, 'TopCare Auto', '654 Service Ln', 'Miami', 'FL', '33101', '305-555-4567'),
(6, 'QuickFix Mechanics', '123 Repair St', 'Los Angeles', 'CA', '90001', '213-555-1234'),
(7, 'Trusted Auto Repair', '456 FixIt Ave', 'San Francisco', 'CA', '94102', '415-555-5678'),
(8, 'AllStar Service', '789 Auto Rd', 'Seattle', 'WA', '98101', '206-555-4321'),
(9, 'Express Care', '101 Fast Ln', 'Houston', 'TX', '77001', '713-555-8765'),
(10, 'Elite Auto Solutions', '202 Driveway', 'Chicago', 'IL', '60601', '312-555-3456');

--INSERT INTO SERVICE HISTORY
INSERT INTO ServiceHistory (ServiceID, UserID, VIN, ServiceProviderID, ServiceDate, Cost, [Description])
VALUES 
(1, 1, '1HGCM82633A123456', 1, '2024-10-10', 250.00, 'Oil change and tire rotation'),
(2, 2, '1HGCM82633A123456', 2, '2024-08-11', 1050.00, 'Break Failure'),
(3, 3, '1HGCM82633A654321', 3, '2024-09-15', 300.00, 'Transmission fluid replacement'),
(4, 4, '1HGCM82633A789012', 4, '2024-07-20', 150.00, 'Battery replacement'),
(5, 5, '1HGCM82633A345678', 5, '2024-06-18', 400.00, 'Air conditioning repair'),
(6, 6, '1HGCM82633A876543', 6, '2024-11-01', 200.00, 'Engine oil change'),
(7, 7, '1HGCM82633A654321', 7, '2024-10-20', 950.00, 'Timing belt replacement'),
(8, 8, '1HGCM82633A789012', 8, '2024-08-25', 175.00, 'Brake pad replacement'),
(9, 9, '1HGCM82633A345678', 9, '2024-05-30', 220.00, 'Coolant system flush'),
(10, 10, '1HGCM82633A876543', 10, '2024-07-04', 500.00, 'Suspension alignment');

--INSERT INTO INCIDENT
INSERT INTO Incident (LocationID, AccidentType, IncidentDate, [Description], AssistanceArrivalTime, [Status], SeverityLevel, VIN)
VALUES 
(1, 'Roadside', '2024-09-19', 'Flat tire on highway', '10:30:00', 'Completed', 2, '1HGCM82633A123456'),
(2, 'Accident', '2024-11-02', 'Minor rear-end collision', '12:45:00', 'In Progress', 3, '1HGCM82633A123456'),
(3, 'Roadside', '2024-10-10', 'Battery jump-start required', '08:15:00', 'Completed', 1, '1HGCM82633A654321'),
(4, 'Accident', '2024-08-25', 'Head-on collision', '15:30:00', 'Completed', 5, '1HGCM82633A789012'),
(5, 'Roadside', '2024-07-14', 'Engine overheating', '09:20:00', 'In Progress', 4, '1HGCM82633A345678'),
(6, 'Accident', '2024-09-01', 'T-bone collision at intersection', '13:00:00', 'Completed', 4, '1HGCM82633A876543'),
(7, 'Roadside', '2024-06-18', 'Tire replacement', '10:45:00', 'Completed', 2, '1HGCM82633A654321'),
(8, 'Accident', '2024-10-05', 'Vehicle overturned due to slippery road', '14:25:00', 'In Progress', 5, '1HGCM82633A789012'),
(9, 'Roadside', '2024-11-12', 'Coolant refill needed', '11:30:00', 'Completed', 1, '1HGCM82633A345678'),
(10, 'Accident', '2024-05-22', 'Side-swipe collision', '09:15:00', 'Completed', 3, '1HGCM82633A876543');

--INSERT INTO ROADSIDEINCIDENT
INSERT INTO RoadsideIncident (RIncidentID, AssistanceType, ServiceCompletionTime, ServiceRating) VALUES 
(1, 'Tire Replacement', '11:00:00', 5),
(3, 'Battery Jump Start', '08:45:00', 4),
(5, 'Coolant Refill', '10:30:00', 3),
(7, 'Fuel Refill Assistance', '11:10:00', 5),
(9, 'Tow Service', '13:20:00', 4)

--INSERT INTO ACCIDENTINCIDENT
INSERT INTO AccidentIncident (AIncidentID, CollisionType, PoliceReportNumber, Fatalities, Cause) VALUES 
(2, 'Rear-end Collision', 'PRN2024-001', 0, 'Driver distraction'),
(4, 'Head-on Collision', 'PRN2024-002', 1, 'Impaired driving'),
(6, 'T-bone Collision', 'PRN2024-003', 0, 'Failure to yield'),
(8, 'Rollover', 'PRN2024-004', 0, 'Slippery road conditions'),
(10, 'Side-swipe', 'PRN2024-005', 0, 'Unsafe lane change')

--FOR VIEWING
select * from SIM;
select * from IOT_DEVICE;
select * from LOCATION;
select * from InsuranceCompany;
select * from Insurance;
select * from USERS;
select * from DEALERSHIP;
select * from VEHICLE;
select * from ServiceProvider;
select * from ServiceHistory;
select * from Incident;
select * from RoadsideIncident;
select * from AccidentIncident;


