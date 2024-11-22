USE DAMG_ASSIGNMENT_GROUP_16
GO

-- Create a Master Key, Certificate, and Symmetric Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongPassword@123';
GO

CREATE CERTIFICATE Cert_DAMG
    WITH SUBJECT = 'Data Encryption Certificate';
GO

CREATE SYMMETRIC KEY SymKey_DAMG
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE Cert_DAMG;
GO

-- Encryption for Users Table
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
UPDATE USERS
SET PhoneNumber = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), CAST(PhoneNumber AS NVARCHAR(MAX))),
    DriverLicenseNumber = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), CAST(DriverLicenseNumber AS NVARCHAR(MAX)));
CLOSE SYMMETRIC KEY SymKey_DAMG;
GO


-- Encryption for Insurance Company Table
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
UPDATE InsuranceCompany
SET ContactNumber = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), CAST(ContactNumber AS NVARCHAR(MAX)));
CLOSE SYMMETRIC KEY SymKey_DAMG;
GO

-- Encryption for Dealership Table
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
UPDATE DEALERSHIP
SET ContactNumber = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), CAST(ContactNumber AS NVARCHAR(MAX)));
CLOSE SYMMETRIC KEY SymKey_DAMG;
GO

-- Encryption for Vehicle Table
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
UPDATE VEHICLE
SET LicenseNumber = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), CAST(LicenseNumber AS NVARCHAR(MAX)));
CLOSE SYMMETRIC KEY SymKey_DAMG;
GO

-- Encryption for ServiceProvider Table
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
UPDATE ServiceProvider
SET PhoneNumber = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), CAST(PhoneNumber AS NVARCHAR(MAX)));
CLOSE SYMMETRIC KEY SymKey_DAMG;
GO

-- Encryption for Incident Table
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
UPDATE Incident
SET [Description] = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), CAST([Description] AS NVARCHAR(MAX)));
CLOSE SYMMETRIC KEY SymKey_DAMG;
GO
-- Create Trigger for Users Table
CREATE OR ALTER TRIGGER trg_EncryptOnInsert_USERS
ON USERS
AFTER INSERT
AS
BEGIN
    OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
    UPDATE USERS
    SET PhoneNumber = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), i.PhoneNumber),
        DriverLicenseNumber = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), i.DriverLicenseNumber)
    FROM USERS u
    JOIN inserted i ON u.UserID = i.UserID;
    CLOSE SYMMETRIC KEY SymKey_DAMG;
END;
GO


-- Create Trigger for InsuranceCompany Table
CREATE OR ALTER TRIGGER trg_EncryptOnInsert_InsuranceCompany
ON InsuranceCompany
AFTER INSERT
AS
BEGIN
    OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
    UPDATE InsuranceCompany
    SET ContactNumber = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), i.ContactNumber)
    FROM InsuranceCompany ic
    JOIN inserted i ON ic.InsuranceProviderID = i.InsuranceProviderID;
    CLOSE SYMMETRIC KEY SymKey_DAMG;
END;
GO

-- Create Trigger for Dealership Table
CREATE OR ALTER TRIGGER trg_EncryptOnInsert_DEALERSHIP
ON DEALERSHIP
AFTER INSERT
AS
BEGIN
    OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
    UPDATE DEALERSHIP
    SET ContactNumber = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), i.ContactNumber)
    FROM DEALERSHIP d
    JOIN inserted i ON d.DealerID = i.DealerID;
    CLOSE SYMMETRIC KEY SymKey_DAMG;
END;
GO

-- Create Trigger for ServiceProvider Table
CREATE OR ALTER TRIGGER trg_EncryptOnInsert_ServiceProvider
ON ServiceProvider
AFTER INSERT
AS
BEGIN
    OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
    UPDATE ServiceProvider
    SET PhoneNumber = ENCRYPTBYKEY(KEY_GUID('SymKey_DAMG'), i.PhoneNumber)
    FROM ServiceProvider sp
    JOIN inserted i ON sp.ServiceProviderID = i.ServiceProviderID;
    CLOSE SYMMETRIC KEY SymKey_DAMG;
END;
GO

-- Decryption Queries
-- Decrypt Users Table
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
SELECT 
    PhoneNumber AS EncryptedPhoneNumber,
    CONVERT(VARCHAR, DECRYPTBYKEY(PhoneNumber)) AS DecryptedPhoneNumber,
    DriverLicenseNumber AS EncryptedDriverLicenseNumber,
    CONVERT(VARCHAR, DECRYPTBYKEY(DriverLicenseNumber)) AS DecryptedDriverLicenseNumber
FROM USERS;
CLOSE SYMMETRIC KEY SymKey_DAMG;
GO

-- Decrypt Insurance Company Table
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
SELECT InsuranceProviderID,
       ProviderName,
	   ContactNumber AS EncryptedContactNumber,
       CONVERT(VARCHAR, DECRYPTBYKEY(ContactNumber)) AS InsuranceContactNumber
FROM InsuranceCompany;
CLOSE SYMMETRIC KEY SymKey_DAMG;
GO

-- Decrypt Dealership Table
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
SELECT DealerID,
       DealerName,
	   ContactNumber AS EncryptedContactNumber,
       CONVERT(VARCHAR, DECRYPTBYKEY(ContactNumber)) AS DealerContactNumber
FROM DEALERSHIP;
CLOSE SYMMETRIC KEY SymKey_DAMG;
GO

-- Decrypt Vehicle Table
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
SELECT DeviceID,
       Model,
       Colour,
	   VIN,
	   LicenseNumber AS EncryptedLicenseNumber,
       CONVERT(VARCHAR, DECRYPTBYKEY(LicenseNumber)) AS LicenseNumber
FROM VEHICLE;
CLOSE SYMMETRIC KEY SymKey_DAMG;
GO

-- Decrypt ServiceProvider Table
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;
SELECT ServiceProviderID,
       ProviderName,
	   PhoneNumber AS EncryptedPhoneNumber,
       CONVERT(VARCHAR, DECRYPTBYKEY(PhoneNumber)) AS PhoneNumber
FROM ServiceProvider;
CLOSE SYMMETRIC KEY SymKey_DAMG;
GO

-- Open the symmetric key
OPEN SYMMETRIC KEY SymKey_DAMG DECRYPTION BY CERTIFICATE Cert_DAMG;

-- Select encrypted and decrypted data from USERS table
SELECT 
    PhoneNumber AS EncryptedPhoneNumber,
    CONVERT(VARCHAR, DECRYPTBYKEY(PhoneNumber)) AS DecryptedPhoneNumber,
    DriverLicenseNumber AS EncryptedDriverLicenseNumber,
    CONVERT(VARCHAR, DECRYPTBYKEY(DriverLicenseNumber)) AS DecryptedDriverLicenseNumber
FROM USERS;

-- Select encrypted and decrypted data from VEHICLE table
SELECT 
    LicenseNumber AS EncryptedLicenseNumber,
    CONVERT(VARCHAR, DECRYPTBYKEY(LicenseNumber)) AS DecryptedLicenseNumber
FROM VEHICLE;

-- InsuranceCompany
SELECT
	ContactNumber as EncryptedInsuranceContactNumber,
	CONVERT(VARCHAR, DECRYPTBYKEY(ContactNumber)) AS DecryptedInsuranceContactNumber
FROM InsuranceCompany;

-- Dealership
SELECT
	ContactNumber as EncryptedDealerContactNumber,
	CONVERT(VARCHAR, DECRYPTBYKEY(ContactNumber)) AS DecryptedDealerContactNumber
FROM DEALERSHIP;

--ServiceProvider
SELECT
	PhoneNumber AS EncryptedServicePhoneNo,
	CONVERT(VARCHAR, DECRYPTBYKEY(PhoneNumber)) AS DecryptedServicePhoneNo
FROM ServiceProvider;

-- Close the symmetric key
CLOSE SYMMETRIC KEY SymKey_DAMG;


