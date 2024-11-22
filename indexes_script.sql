use DAMG_ASSIGNMENT_GROUP_16
GO

-- SIM table
CREATE NONCLUSTERED INDEX IDX_SIM_IMEI
ON SIM (IMEI)
INCLUDE (IMSI, DialNumber);

--IOT_DEVICE table
CREATE NONCLUSTERED INDEX IX_IOT_DEVICE_DeviceID_Temperature_Speed_FuelRange
ON IOT_DEVICE (DeviceID, Temperature, Speed, FuelRange);

--INCIDENT TABLE Enhance queries filtering by Status, SeverityLevel, or joining with VIN
CREATE NONCLUSTERED INDEX IX_Incident_VIN_Status_SeverityLevel
ON Incident (VIN, [Status], SeverityLevel);

