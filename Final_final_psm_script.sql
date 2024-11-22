USE DAMG_ASSIGNMENT_GROUP_16;
GO

-- CRUCIAL PROCEDURES
-- 1) Procedure to retrieve service history on a specific vehicle

CREATE PROCEDURE GetServiceHistory
    @VIN VARCHAR(17)
AS
BEGIN
    SELECT 
        SH.ServiceID,
        SH.ServiceDate,
        SP.ProviderName AS ServiceProvider,
        SH.Cost,
        SH.[Description]
    FROM 
        ServiceHistory SH
    JOIN ServiceProvider SP ON SH.ServiceProviderID = SP.ServiceProviderID
    WHERE 
        SH.VIN = @VIN
    ORDER BY 
        SH.ServiceDate DESC;
END;
GO

-- Retrieve service history for a vehicle with VIN '1HGCM82633A123456'
EXEC GetServiceHistory 
    @VIN = '1HGCM82633A123456';
GO


-- ====================================================================================
--                              END OF PROCEDURE: <GetServiceHistory>
-- ====================================================================================


-- 2) Procedure to display IoT device and its associated location by entering the IncidentID for a specific vehicle

CREATE PROCEDURE GetIoTDeviceAndLocationDetails
    @IncidentID INT
AS
BEGIN
    SELECT 
        I.IncidentID,
        I.VIN,
        D.DeviceID,
        D.Manufacturer,
        D.InstalationDate,
        D.HardwareVersion,
        D.Speed,
        D.Temperature,
        D.FuelRange,
        L.LocationID,
        L.Latitude,
        L.Longitude,
        L.Location_TimeStamp
    FROM 
        Incident I
    INNER JOIN 
        LOCATION L ON I.LocationID = L.LocationID
    INNER JOIN 
        IOT_DEVICE D ON L.DeviceID = D.DeviceID
    WHERE 
        I.IncidentID = @IncidentID;
END;
GO

-- Execute the procedure with an example IncidentID
EXEC GetIoTDeviceAndLocationDetails 
    @IncidentID = 1;
GO


-- ====================================================================================
--                              END OF PROCEDURE: <GetIoTDeviceAndLocationDetails>
-- ====================================================================================


-- 3) Procedure to delete vehicle data after checking active insurances or incidents

CREATE PROCEDURE DeleteVehicle
    @VIN VARCHAR(17)
AS
BEGIN
    -- Ensure no open incidents (either 'Initiated' or 'In Progress')
    IF EXISTS (SELECT 1 FROM Incident WHERE VIN = @VIN AND Status IN ('Initiated', 'In Progress'))
    BEGIN
        PRINT 'Cannot delete vehicle with active incidents.';
        RETURN;
    END;
    
    -- Ensure no active insurance (Status = 'Active')
    IF EXISTS (SELECT 1 FROM Insurance WHERE InsuranceNumber IN (SELECT InsuranceNumber FROM VEHICLE WHERE VIN = @VIN) AND [Status] = 'Active')
    BEGIN
        PRINT 'Cannot delete vehicle with active insurance.';
        RETURN;
    END;

    -- Delete associated records in ServiceHistory
    DELETE FROM ServiceHistory WHERE VIN = @VIN;

    -- Delete associated records in Incident (if any)
    DELETE FROM Incident WHERE VIN = @VIN;

    -- Delete the vehicle record
    DELETE FROM VEHICLE WHERE VIN = @VIN;

    PRINT 'Vehicle and associated records have been successfully deleted.';
END;
GO

-- Demo 
EXEC DeleteVehicle @VIN = '1HGCM82633A123456';
GO


-- ====================================================================================
--                              END OF PROCEDURE: <DeleteVehicle>
-- ====================================================================================


-- 4) Procedure to update insurance for a given vehicle

CREATE PROCEDURE UpdateVehicleInsurance
    @VIN VARCHAR(17),
    @InsuranceNumber INT,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    UPDATE Insurance
    SET 
        StartDate = @StartDate,
        EndDate = @EndDate
    WHERE 
        InsuranceNumber = @InsuranceNumber;

    UPDATE VEHICLE
    SET 
        InsuranceNumber = @InsuranceNumber
    WHERE 
        VIN = @VIN;
END;
GO

-- Update insurance details for a vehicle with VIN '1HGCM82633A123456'
EXEC UpdateVehicleInsurance 
    @VIN = '1HGCM82633A123456',
    @InsuranceNumber = 1001,
    @StartDate = '2024-01-01',
    @EndDate = '2025-01-01';
GO


-- ====================================================================================
--                              END OF PROCEDURE: <UpdateVehicleInsurance>
-- ====================================================================================


-- CRUCIAL VIEWS
-- 1) Vehicle summary that displays its owners, insurance details and number of active and rectified incidents

CREATE VIEW VehicleSummary AS
SELECT 
    V.VIN,
    V.Model,
    V.[Year],
    V.Colour,
    V.FuelType,
    U.Name AS OwnerName,
    U.PhoneNumber AS OwnerContact,
    IC.ProviderName AS InsuranceProvider,
    I.PolicyNumber AS InsurancePolicyNumber,
    I.StartDate AS PolicyStartDate,
    I.EndDate AS PolicyEndDate,
    I.[Status] AS InsuranceStatus,
    COUNT(Inc.IncidentID) AS TotalIncidents,
    SUM(CASE WHEN Inc.[Status] IN ('Initiated', 'In Progress') THEN 1 ELSE 0 END) AS PendingIncidents,
    SUM(CASE WHEN Inc.[Status] = 'Completed' THEN 1 ELSE 0 END) AS ProcessedIncidents
FROM 
    VEHICLE V
LEFT JOIN 
    USERS U ON V.UserID = U.UserID
LEFT JOIN 
    Insurance I ON V.InsuranceNumber = I.InsuranceNumber
LEFT JOIN 
    InsuranceCompany IC ON I.InsuranceProviderID = IC.InsuranceProviderID
LEFT JOIN 
    Incident Inc ON V.VIN = Inc.VIN
GROUP BY 
    V.VIN, V.Model, V.[Year], V.Colour, V.FuelType, U.Name, U.PhoneNumber, 
    IC.ProviderName, I.PolicyNumber, I.StartDate, I.EndDate, I.[Status];
GO

-- Demo
SELECT * FROM VehicleSummary;
GO


-- ====================================================================================
--                              END OF VIEW: <VehicleSummary>
-- ====================================================================================

-- 2) View of incident report for a given vehicle
CREATE VIEW IncidentReport AS
SELECT 
    I.IncidentID,
    I.VIN,
    I.AccidentType,
    I.IncidentDate,
    I.[Status],
    I.SeverityLevel,
    CASE 
        WHEN I.AccidentType = 'Roadside' THEN RI.AssistanceType
        ELSE AI.CollisionType
    END AS IncidentDetails,
    CASE 
        WHEN I.AccidentType = 'Roadside' THEN NULL
        ELSE AI.Cause
    END AS Cause
FROM 
    Incident I
LEFT JOIN RoadsideIncident RI ON I.IncidentID = RI.RIncidentID
LEFT JOIN AccidentIncident AI ON I.IncidentID = AI.AIncidentID;
GO

-- Retrieve all incidents
SELECT * 
FROM IncidentReport
ORDER BY SeverityLevel DESC;

-- Retrieve incidents for a specific vehicle
SELECT * 
FROM IncidentReport
WHERE VIN = '1HGCM82633A123456';

-- Retrieve only roadside incidents
SELECT * 
FROM IncidentReport
WHERE AccidentType = 'Roadside';
GO


-- ====================================================================================
--                              END OF VIEW: <IncidentReport>
-- ====================================================================================


-- 3) View for service cost analysis of a given vehicle
CREATE VIEW ServiceCostAnalysis AS
SELECT 
    V.VIN,
    V.Model,
    V.[Year],
    U.Name AS OwnerName,
    COUNT(SH.ServiceID) AS TotalServices,
    SUM(SH.Cost) AS TotalCost
FROM 
    VEHICLE V
JOIN USERS U ON V.UserID = U.UserID
JOIN ServiceHistory SH ON V.VIN = SH.VIN
GROUP BY 
    V.VIN, V.Model, V.[Year], U.Name;
GO

-- Retrieve total service costs for all vehicles
SELECT * 
FROM ServiceCostAnalysis;

-- Retrieve service cost analysis for a specific vehicle
SELECT * 
FROM ServiceCostAnalysis
WHERE VIN = '1HGCM82633A123456';

-- Retrieve vehicles with service costs exceeding $500
SELECT * 
FROM ServiceCostAnalysis
WHERE TotalCost > 500;
GO


-- ====================================================================================
--                              END OF VIEW: <ServiceCostAnalysis>
-- ====================================================================================


-- CRUCIAL USER-DEFINED FUNCTIONS
-- 1) Function to determine driving style based on IoT device details for insurance purposes
CREATE FUNCTION GetAvgSpeedAndDrivingStyle (
    @DeviceID VARCHAR(20)
)
RETURNS TABLE
AS
RETURN (
    SELECT 
        AVG(Speed) AS AvgSpeed,
        CASE 
            WHEN AVG(Speed) < 40 THEN 'Slow'
            WHEN AVG(Speed) BETWEEN 40 AND 70 THEN 'Normal'
            ELSE 'Aggressive'
        END AS DrivingStyle
    FROM IOT_DEVICE
    WHERE DeviceID = @DeviceID
);
GO

-- Demo
SELECT *
FROM GetAvgSpeedAndDrivingStyle('01234');
GO


-- ====================================================================================
--                              END OF FUNCTION: <GetAvgSpeedAndDrivingStyle>
-- ====================================================================================


-- 2) Function to show active incidents along with user details and insurance details
CREATE FUNCTION GetActiveIncidentsDetails ()
RETURNS TABLE
AS
RETURN (
    SELECT 
        i.IncidentID,
        i.AccidentType,
        i.Description,
        i.Status,
        u.Name AS UserName,
        u.PhoneNumber,
        ins.PolicyNumber,
        ins.Status AS InsuranceStatus,
        ins.StartDate,
        ins.EndDate
    FROM Incident i
    INNER JOIN VEHICLE v ON i.VIN = v.VIN
    INNER JOIN USERS u ON v.UserID = u.UserID
    INNER JOIN Insurance ins ON v.InsuranceNumber = ins.InsuranceNumber
    WHERE i.Status = 'In Progress' OR i.Status = 'Initiated'
);
GO

-- Demo
SELECT *
FROM GetActiveIncidentsDetails();
GO


-- ====================================================================================
--                              END OF FUNCTION: <GetActiveIncidentsDetails>
-- ====================================================================================


-- 3) Based on the temperature, display driving conditions
CREATE FUNCTION GetDrivingConditions (
    @DeviceID VARCHAR(20)
)
RETURNS TABLE
AS
RETURN (
    SELECT 
        DeviceID,
        Temperature,
        CASE 
            WHEN Temperature < 0 THEN 'Hazardous'
            WHEN Temperature BETWEEN 0 AND 20 THEN 'Cold'
            WHEN Temperature BETWEEN 20 AND 35 THEN 'Normal'
            ELSE 'Hot'
        END AS DrivingConditions
    FROM IOT_DEVICE
    WHERE DeviceID = @DeviceID
);
GO

-- Demo
SELECT * 
FROM GetDrivingConditions('12345');
GO


-- ====================================================================================
--                              END OF FUNCTION: <GetDrivingConditions>
-- ====================================================================================


-- CRUCIAL TRIGGERS
-- 1) Trigger to update IoT_DEVICE location ID if a new location comes into DB
CREATE TRIGGER trg_UpdateIOTDeviceLocation
ON LOCATION
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the IOT_DEVICE table with the new LocationID
    UPDATE IOT_DEVICE
    SET [Location] = i.LocationID
    FROM IOT_DEVICE d
    INNER JOIN INSERTED i
    ON d.DeviceID = i.DeviceID;
END;
GO

-- Location ID for an IoT device before a new incident
SELECT [Location] 
FROM IOT_DEVICE 
WHERE DeviceID = '01234';

-- Insert a new location value
INSERT INTO LOCATION (DeviceID, Latitude, Longitude, Location_TimeStamp) 
VALUES ('01234', 40.712776, -74.005974, '2024-11-18 10:00:00');

-- Verify Location ID after the new location value is added
SELECT [Location] 
FROM IOT_DEVICE 
WHERE DeviceID = '01234';
GO


-- ====================================================================================
--                              END OF TRIGGER: <trg_UpdateIOTDeviceLocation>
-- ====================================================================================


-- 2) Log the changes in the ServiceHistory table in a new table
CREATE TABLE ServiceLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    ServiceID INT NOT NULL,
    UserID INT NOT NULL,
    VIN VARCHAR(17) NOT NULL,
    ServiceProviderID INT,
    ServiceDate DATE NOT NULL,
    Cost DECIMAL(10,2),
    ChangeType VARCHAR(10) NOT NULL,
    ChangeDate DATETIME NOT NULL
);

-- 2) Trigger to track service history updates for a given vehicle 
GO
CREATE TRIGGER trg_TrackServiceHistoryChanges
ON ServiceHistory
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Log newly added service history records
    IF EXISTS (SELECT 1 FROM INSERTED)
    BEGIN
        INSERT INTO ServiceLog (
            ServiceID, 
            UserID, 
            VIN, 
            ServiceProviderID, 
            ServiceDate, 
            Cost, 
            ChangeType, 
            ChangeDate
        )
        SELECT
            i.ServiceID, 
            i.UserID, 
            i.VIN, 
            i.ServiceProviderID, 
            i.ServiceDate, 
            i.Cost, 
            'Insert' AS ChangeType, 
            GETDATE() AS ChangeDate
        FROM INSERTED i;
    END;

    -- Log updated service history records
    IF EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO ServiceLog (
            ServiceID, 
            UserID, 
            VIN, 
            ServiceProviderID, 
            ServiceDate, 
            Cost,  
            ChangeType, 
            ChangeDate
        )
        SELECT
            d.ServiceID, 
            d.UserID, 
            d.VIN, 
            d.ServiceProviderID, 
            d.ServiceDate, 
            d.Cost, 
            'Update' AS ChangeType, 
            GETDATE() AS ChangeDate
        FROM DELETED d
        INNER JOIN INSERTED i ON d.ServiceID = i.ServiceID;
    END;
END;
GO

--Demo
INSERT INTO ServiceHistory (ServiceID, UserID, VIN, ServiceProviderID, ServiceDate, Cost, Description)
VALUES (13, 3, '1HGCM82633A123456', 1, '2024-11-15', 2000.00, 'Initial Service');

UPDATE ServiceHistory
SET Cost = 2500.00
WHERE ServiceID = 13;

SELECT * FROM ServiceLog;

-- ====================================================================================
--                              END OF TRIGGER: <trg_TrackServiceHistoryChanges>
-- ====================================================================================
