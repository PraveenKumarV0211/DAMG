# Connected Vehicle Management System

Enterprise IoT database for vehicle incident tracking, insurance management, and service history with real-time telemetry integration.

![Dashboard](images/dashboard.png)

## Quick Stats
- **14 Tables** | **4 Procedures** | **3 Views** | **3 UDFs** | **7 Triggers**
- **AES-256 Encryption** on 5 sensitive tables
- **10+ Vehicle Models Tracked** | **72% Active Insurance Policies**
- **3x Incident Growth** (May-Nov 2024)

---

## Architecture
```
IOT_DEVICE (GPS, Speed, Temp) → LOCATION → INCIDENT → RoadsideIncident
                                                      → AccidentIncident
     ↓
  VEHICLE ← INSURANCE ← InsuranceCompany
     ↓
  USERS → ServiceHistory → ServiceProvider
```

**Key Relationships:**
- 1:1 → Vehicle ↔ IoT Device ↔ Insurance
- 1:M → User ↔ Vehicles, Incident ↔ Location
- M:M → Users ↔ Service Providers

---

## Features

### Security
- **AES-256 symmetric encryption** with auto-triggers on INSERT
- **5 encrypted tables**: USERS, VEHICLE, InsuranceCompany, DEALERSHIP, ServiceProvider
- Certificate-based key management

### Real-Time Tracking
- **GPS coordinates** (lat/long to 6 decimal precision)
- **Vehicle telemetry**: Speed, temperature, fuel range
- **Incident severity**: 5-level classification (1=minor, 5=critical)

### Analytics
```sql
-- Driving behavior classification
GetAvgSpeedAndDrivingStyle(@DeviceID)
  → Returns: AvgSpeed, DrivingStyle (Slow/Normal/Aggressive)

-- Active incidents with insurance validation
GetActiveIncidentsDetails()
  → 65% Roadside | 35% Accidents

-- Service cost analysis
ServiceCostAnalysis
  → Total: $X across Y services
```

### Automation
- **Location updates**: Trigger auto-updates IoT device location on GPS insert
- **Service logging**: Immutable audit trail for all maintenance records
- **Cascading deletes**: Safety checks prevent deletion of vehicles with active incidents/insurance

---

## Tech Stack

**Database:** SQL Server | **Query:** T-SQL | **Viz:** Tableau | **Security:** AES-256, Certificate Management

---

## Setup
```bash
# 1. Create database
sqlcmd -S localhost -i schema.sql

# 2. Configure encryption
sqlcmd -S localhost -i encryption.sql

# 3. Deploy SQL objects
sqlcmd -S localhost -i procedures_views_functions.sql

# 4. Open Tableau
tableau Dashboard.twbx
```

---

## Sample Queries
```sql
-- Get vehicles with pending incidents
SELECT * FROM VehicleSummary WHERE PendingIncidents > 0;

-- Classify driver behavior
SELECT * FROM GetAvgSpeedAndDrivingStyle('01234');

-- High-cost maintenance vehicles
SELECT * FROM ServiceCostAnalysis WHERE TotalCost > 2000;
```

---

## Data Insights

**From Tableau Analysis:**
- **Incident Distribution**: 65% Roadside, 35% Accidents
- **High-Risk Models**: Audi A4, BMW 3 Series (40% higher incident rate)
- **Insurance**: 72% Active | 18% Expired | 7% Pending | 3% Cancelled
- **Peak Months**: Nov-Dec (winter conditions)
- **Temporal Trend**: 3x growth May→Nov 2024

---

## Team
**Group 16** | Northeastern University | DAMG 6210 Fall 2024

---

