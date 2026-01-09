# Portal 360 Database Schema Analysis Report (Updated for EF Core 8+)

## Executive Summary

This migration file (`MigrationPortal360.cs`) creates the complete database schema for the nddPrint Control Portal 360 system - a comprehensive enterprise print management and monitoring solution.

### Database Scale (UPDATED COUNTS)

**Total Database Objects: 1,001+**

| Object Type | Count |
|-------------|-------|
| **Tables** | 205 |
| **Stored Procedures** | 684 |
| **Functions** | 73 |
| **Views** | 32 |
| **Triggers** | 1 |
| **User-Defined Types** | 6 |
| **Foreign Keys** | 184 |
| **Seed Data** | ~500 records |

---

## Table of Contents
1. [User-Defined Table Types](#user-defined-table-types)
2. [Functions](#functions)
3. [Core Entities](#core-entities)
4. [Stored Procedures Overview](#stored-procedures-overview)
5. [Triggers](#triggers)
6. [Views](#views)
7. [Seed Data](#seed-data)
8. [Business Domain Analysis](#business-domain-analysis)
9. [EF Core Migration Strategy](#ef-core-migration-strategy)

---

## User-Defined Table Types (6)

**EF Core Limitation:** Must create via SQL  
**Modern Solution:** Eliminate usage with JSON columns (EF Core 7+)

### 1. **AccountIdList**
- **Purpose**: Pass collections of account IDs to stored procedures
- **Structure**: Single column `Id` (int)
- **✅ Modern Alternative**: `ExecuteUpdate` with `Contains()` - no UDT needed

### 2. **BrandsUDT**
- **Purpose**: Bulk operations with printer brands
- **Structure**: `BrandName` (NVARCHAR(100))
- **✅ Modern Alternative**: `List<string>` + `ExecuteUpdate`

### 3. **IntTable**
- **Purpose**: Generic integer collection with primary key
- **Structure**: `INTID` (int, PRIMARY KEY)
- **✅ Modern Alternative**: `List<int>` + `Contains()` or `ExecuteUpdate`

### 4. **PlainCounters**
- **Purpose**: Bulk counter readings for printers
- **Structure**: 
  - `CounterTypeID` (int, PRIMARY KEY)
  - `CounterMono` (int)
  - `CounterColor` (int)
  - `CounterTotal` (int)
- **✅ Modern Alternative**: JSON columns for storage, DTO classes for passing

### 5. **PrintersModelsUDT**
- **Purpose**: Bulk operations with printer models and brands
- **Structure**: 
  - `BrandName` (NVARCHAR(100))
  - `PrinterModelName` (NVARCHAR(100))
- **✅ Modern Alternative**: JSON columns or batch processing

### 6. **ReferenceCounterUDT**
- **Purpose**: Reference counter readings for validation
- **Structure**:
  - `CounterReadingID` (int, PRIMARY KEY)
  - `ReferenceMono` (int, nullable)
  - `ReferenceColor` (int, nullable)
- **✅ Modern Alternative**: JSON columns or batch processing

**Migration Strategy:**
```csharp
// Still need to create via SQL (EF Core limitation)
migrationBuilder.Sql("CREATE TYPE [dbo].[IntTable] AS TABLE(...)");

// But eliminate usage in new code with ExecuteUpdate
await context.Accounts
    .Where(a => accountIds.Contains(a.AccountID))
    .ExecuteUpdateAsync(s => s.SetProperty(a => a.IsActive, true));
```

---

## Functions (73)

### Categorization (Updated for Modern EF Core)

| Type | Count | Convert (EF8+) | Keep SQL | Notes |
|------|-------|----------------|----------|-------|
| **Simple Scalar** | 30 | 95% (28) | 5% (2) | C# extension methods |
| **Complex Scalar** | 25 | 30% (8) | 70% (17) | Cost calculations, complex logic |
| **Table-Valued (Hierarchical)** | 5 | **100%** (5) | 0% | **HierarchyId makes these fast!** |
| **Reporting** | 13 | 10% (1) | 90% (12) | Keep reporting infrastructure |

**Target: Convert 50-55 functions (68-75%)**

### Key Functions to Convert

#### 1. **AccountHasAliases** ✅ Convert
- **Type**: Scalar Function
- **Parameters**: `@AccountID INT`
- **Returns**: `BIT`
- **EF Core Alternative**:
```csharp
public static async Task<bool> HasAliasesAsync(
    this Account account, Portal360DbContext context)
{
    return await context.AccountAliases
        .AnyAsync(aa => aa.AccountID == account.AccountID);
}
```

#### 2. **fn_360_GetAllPrintersFromCostAccounts** ✅ Convert with HierarchyId
- **Type**: Table-Valued Function (Recursive)
- **Parameters**: `@CostAccountID INT`
- **Returns**: Table with `PrinterDeviceID`
- **Purpose**: Recursively retrieve all printers from cost account hierarchy
- **🆕 EF Core 8+ Alternative (FAST)**:
```csharp
public async Task<List<int>> GetAllPrinterDeviceIdsAsync(int costAccountId)
{
    var root = await _context.CostAccounts
        .Where(ca => ca.CostAccountID == costAccountId)
        .Select(ca => ca.HierarchyPath)
        .FirstAsync();
    
    // Server-side hierarchy query - as fast as SQL!
    return await _context.PrintersDevices
        .Where(pd => pd.CostAccount!.HierarchyPath.IsDescendantOf(root))
        .Select(pd => pd.PrinterDeviceID)
        .ToListAsync();
}
```

**Prerequisites:** Add `HierarchyId HierarchyPath` column to CostAccounts table

#### 3. **fn_360_GetCostAccountManaged** ✅ Convert with HierarchyId
- **Type**: Table-Valued Function (Recursive)
- **Parameters**: `@UserManagerID INT`
- **Returns**: Table with `AccountID`
- **Purpose**: Get all cost accounts managed by a specific user manager
- **🆕 EF Core 8+ Alternative**:
```csharp
public async Task<List<int>> GetManagedCostAccountsAsync(int userManagerId)
{
    // Get root accounts managed by user
    var rootAccounts = await _context.CostAccountsManagers
        .Where(cam => cam.AccountID == userManagerId)
        .Select(cam => cam.CostAccount.HierarchyPath)
        .ToListAsync();
    
    // Get all descendants
    return await _context.CostAccounts
        .Where(ca => rootAccounts.Any(root => ca.HierarchyPath.IsDescendantOf(root)))
        .Select(ca => ca.CostAccountID)
        .ToListAsync();
}
```

### Other Notable Functions

**Simple Scalar (Convert to C# Extensions):**
- `GetAccountPermission` - Permission lookup
- `GetUserEmailExists` - Email validation
- `GetCostAccountName` - Name lookup
- `IsConsolidated` - Printer status check
- `GetLastCounter` - Counter reading retrieval

**Complex Scalar (Keep in SQL):**
- `TotalCostCalcColor` - Complex cost calculation with business rules
- `TotalCostCalcMono` - Mono cost calculation
- `getCubeTable` - Analytics cube queries
- `getParametersForReports` - Reporting infrastructure

---

## Core Entities (205 Tables)

### Domain Structure

**Core Business Domains:**
1. **User Management** (40 tables) - Accounts, domains, authentication, groups
2. **Device Management** (35 tables) - Printers, models, brands, queues
3. **Job Tracking** (25 tables) - Print jobs, scan jobs, job history
4. **Cost Management** (20 tables) - Cost accounts, cost groups, pricing
5. **Policy Engine** (15 tables) - Policies, rules, permissions
6. **Quotas System** (25 tables) - Credits, rules, prepaid cards, payments
7. **Analytics** (20 tables) - Cubes (day/week/month aggregations)
8. **Audit/Logging** (10 tables) - Audit trails, change tracking
9. **Integration** (10 tables) - External system sync, queues
10. **Configuration** (5 tables) - System settings, UI preferences

### Key Entity Examples

#### 1. **Accounts** (User entity)
```csharp
public class Account
{
    public int AccountID { get; set; }
    public int DomainID { get; set; }
    public string LogonName { get; set; } = null!;
    public string? FullName { get; set; }
    public string? Email { get; set; }
    public bool Removed { get; set; }
    public DateTime ChangedDate { get; set; }
    public Guid AccountGuidId { get; set; }
    public int? CostAccountID { get; set; }
    
    // Navigation properties
    public Domain Domain { get; set; } = null!;
    public CostAccount? CostAccount { get; set; }
    public ICollection<PrintJob> PrintJobs { get; set; }
    public ICollection<AccountAlias> AccountAliases { get; set; }
}
```

#### 2. **CostAccounts** (Hierarchical entity)
```csharp
public class CostAccount
{
    public int CostAccountID { get; set; }
    public string CostAccountName { get; set; } = null!;
    public string CostAccountCode { get; set; } = null!;
    public int? CostAccountParentID { get; set; }
    
    // 🆕 Add for EF Core 8+ performance
    public HierarchyId HierarchyPath { get; set; }
    
    // Navigation properties
    public CostAccount? Parent { get; set; }
    public ICollection<CostAccount> Children { get; set; }
    public ICollection<Account> Accounts { get; set; }
    public ICollection<PrinterDevice> Printers { get; set; }
}
```

#### 3. **PrintJobs** (Transaction entity)
```csharp
public class PrintJob
{
    public long PrintJobID { get; set; }
    public int? AccountID { get; set; }
    public long? PrinterDeviceID { get; set; }
    public DateTime DatePrinted { get; set; }
    public int PagesMono { get; set; }
    public int PagesColor { get; set; }
    public int Copies { get; set; }
    public decimal? Cost { get; set; }
    public string? DocumentName { get; set; }
    
    // Navigation properties
    public Account? Account { get; set; }
    public PrinterDevice? PrinterDevice { get; set; }
}
```

### Historical/Audit Tables

**Soft Delete Pattern** (40 tables):
- `AccountsRemoved`
- `CostAccountsRemoved`
- `PrintersDevicesRemoved`
- `PoliciesRemoved`
- etc.

**🆕 Modern Alternative:** Use Temporal Tables (EF Core 6+)
```csharp
builder.ToTable("Accounts", t => t.IsTemporal());
```

---

## Stored Procedures Overview (684)

### By Module (Updated Conversion Targets)

| Module | Count | Convert (EF8+) | Keep SQL | Key Features |
|--------|-------|----------------|----------|--------------|
| **Accounts** | 100 | 65 (65%) | 35 | 🆕 Bulk ops with ExecuteUpdate |
| **Printers** | 120 | 75 (63%) | 45 | 🆕 Bulk ops + simple CRUD |
| **Print Jobs** | 100 | 25 (25%) | 75 | Keep analytics/reporting |
| **Cost Accounts** | 60 | 45 (75%) | 15 | 🆕 HierarchyId enables conversion |
| **Quotas** | 100 | 50 (50%) | 50 | Mix of CRUD + complex logic |
| **Policies** | 60 | 20 (33%) | 40 | Complex rule engine |
| **Dashboard** | 80 | 10 (13%) | 70 | Keep reporting |
| **Process Queues** | 40 | 30 (75%) | 10 | Background services |
| **Integration** | 50 | 15 (30%) | 35 | External dependencies |
| **Misc** | 74 | 50 (68%) | 24 | Various utilities |

**Total: Convert 400-450 (58-66%)**

### Conversion Examples

#### Simple CRUD ✅ Convert
```sql
-- OLD: proc_360_Accounts_Update
CREATE PROCEDURE proc_360_Accounts_Update
    @AccountID INT,
    @FullName NVARCHAR(255),
    @Email NVARCHAR(255)
AS BEGIN
    UPDATE Accounts 
    SET FullName = @FullName, Email = @Email, ChangedDate = GETDATE()
    WHERE AccountID = @AccountID
END
```

```csharp
// NEW: Repository method
public async Task UpdateAsync(Account account)
{
    account.ChangedDate = DateTime.UtcNow;
    _context.Accounts.Update(account);
    await _context.SaveChangesAsync();
}
```

#### Bulk Operations 🆕 Convert with ExecuteUpdate
```sql
-- OLD: proc_360_Accounts_BulkDisable
CREATE PROCEDURE proc_360_Accounts_BulkDisable
    @AccountIds IntTable READONLY
AS BEGIN
    UPDATE Accounts SET IsActive = 0
    WHERE AccountID IN (SELECT INTID FROM @AccountIds)
END
```

```csharp
// NEW: Fast bulk operation (EF Core 7+)
public async Task<int> BulkDisableAsync(List<int> accountIds)
{
    return await _context.Accounts
        .Where(a => accountIds.Contains(a.AccountID))
        .ExecuteUpdateAsync(s => s
            .SetProperty(a => a.IsActive, false)
            .SetProperty(a => a.ChangedDate, DateTime.UtcNow));
}
```

#### Hierarchical Queries 🆕 Convert with HierarchyId
```sql
-- OLD: proc_360_CostAccounts_GetHierarchy (Recursive CTE)
CREATE PROCEDURE proc_360_CostAccounts_GetHierarchy
    @RootID INT
AS BEGIN
    WITH CTE AS (
        SELECT * FROM CostAccounts WHERE CostAccountID = @RootID
        UNION ALL
        SELECT ca.* FROM CostAccounts ca
        INNER JOIN CTE ON ca.CostAccountParentID = CTE.CostAccountID
    )
    SELECT * FROM CTE
END
```

```csharp
// NEW: Fast HierarchyId query (EF Core 8+)
public async Task<List<CostAccount>> GetHierarchyAsync(int rootId)
{
    var root = await _context.CostAccounts.FindAsync(rootId);
    
    return await _context.CostAccounts
        .Where(ca => ca.HierarchyPath.IsDescendantOf(root!.HierarchyPath))
        .ToListAsync();
}
```

#### Complex Reporting ❌ Keep in SQL
```sql
-- KEEP: proc_360_Dashboard_RetrieveStatisticsTopUser
-- Reason: Complex 5+ table joins, heavy aggregations, performance-critical
CREATE PROCEDURE proc_360_Dashboard_RetrieveStatisticsTopUser
    @StartDate DATETIME,
    @EndDate DATETIME
AS BEGIN
    -- Complex analytics query
END
```

---

## Triggers (1)

### TrUpdatePrintJobsCube

**Decision:** ❌ Keep in SQL (performance-critical)

**Purpose:** Updates analytics cubes when print jobs are inserted/updated/deleted

**Tables Updated:**
- `CubeMachineIDDay`, `CubeMachineIDWeek`, `CubeMachineIDMonth`
- `CubeCostAccountIDDay`, `CubeCostAccountIDWeek`, `CubeCostAccountIDMonth`
- `CubeAccountIDDay`, `CubeAccountIDWeek`, `CubeAccountIDMonth`

**Why Keep:** 
- Real-time analytics updates
- Transaction-safe (atomic with print job changes)
- Complex multi-table updates
- Performance-critical for dashboard

**Alternative (Not Recommended Initially):**
- Domain events + background processing
- Risk of inconsistency and performance degradation

---

## Views (32)

### All Views - Map as Keyless Entities

**Decision:** Map all 32 as keyless entities, keep SQL views

**Categorization:**
- **Retrieval Views** (10): `vw_Accounts_RetrieveAll`, `vw_PrintersDevices_RetrieveAll`
- **Dashboard/Reporting** (15): `vw_360_Dashboard_*`, `vw_360_CubeCube_RetrieveAll`
- **Integration** (5): `vw_360_SyncHost_*`
- **Utility** (2): `vw_Sites_RetrieveAll`, `vw_Products`

**EF Core Mapping:**
```csharp
[Keyless]
public class AccountsRetrieveAllView
{
    public int AccountID { get; set; }
    public string LogonName { get; set; } = null!;
    public string PathAccount { get; set; } = null!;
    public string? CostAccountName { get; set; }
    // ... all view columns
}

// Configuration
builder.ToView("vw_Accounts_RetrieveAll");
builder.HasNoKey();

// Usage
var accounts = await _context.AccountsRetrieveAllView
    .Where(a => a.DomainID == domainId)
    .ToListAsync();
```

---

## Seed Data (~500 records)

### All Seed Data → 100% C# (EF Core)

**Categories:**

1. **Reference Data** (via `HasData()`)
   - DomainTypes (4)
   - JobTypes (4)
   - CounterTypes (5)
   - PaperSizes (10)
   - PrintQualities (5)

2. **System Configuration** (via Seeder class)
   - Default Site (1)
   - Default Domain "nddPrint" (1)
   - Admin Account (1)
   - System Operators (2)
   - Default Cost Group (1)

3. **Application Data** (via Seeder class)
   - Print Applications (~50)
   - Print Application Rules (~20)
   - Driver Qualities (~50)
   - Billing Rules (~10)
   - Grid Columns (~10)

**Implementation:**

```csharp
// Static reference data - HasData()
public class DomainTypeConfiguration : IEntityTypeConfiguration<DomainType>
{
    public void Configure(EntityTypeBuilder<DomainType> builder)
    {
        builder.HasData(
            new DomainType { DomainTypeID = 1, DomainTypeName = "Active Directory" },
            new DomainType { DomainTypeID = 2, DomainTypeName = "LDAP" },
            new DomainType { DomainTypeID = 3, DomainTypeName = "Internal Database" },
            new DomainType { DomainTypeID = 4, DomainTypeName = "nddPrint" }
        );
    }
}

// Complex/dynamic data - Seeder class
public class Portal360Seeder
{
    public async Task SeedAsync()
    {
        await SeedDomainsAsync();
        await SeedAdminUserAsync();
        await SeedPrintApplicationsAsync();
        // ...
    }
}
```

---

## Business Domain Analysis

### 1. User & Authentication Domain

**Core Entities:**
- `Accounts` - User accounts
- `Domains` - Authentication domains (AD, LDAP, Internal, nddPrint)
- `AccountsPassport` - Password/authentication data
- `AccountsAliases` - User aliases
- `AccountsGroups` - User groups
- `AccountsPinCodes` - PIN code authentication

**Complexity:** Medium - Standard user management with multi-domain support

### 2. Device Management Domain

**Core Entities:**
- `PrintersDevices` - Physical printer devices
- `PrintersModels` - Printer model catalog
- `PrintersBrands` - Printer manufacturers
- `PrintersQueues` - Print queues
- `Machines` - Host machines

**Complexity:** High - Complex device topology, consolidation, billing rules

### 3. Print Job Domain

**Core Entities:**
- `PrintJobs` - Print job transactions
- `PrintJobsSaveToner` - Eco-mode jobs
- `CubeCube` - Main analytics cube
- `Cube*Day/Week/Month` - Time-series aggregations

**Complexity:** Very High - High volume, analytics, real-time updates

### 4. Cost Management Domain

**Core Entities:**
- `CostAccounts` - Hierarchical cost centers
- `CostGroups` - Cost calculation rules
- `CostAccountsManagers` - Manager permissions

**Complexity:** High - Hierarchical structure, complex calculations

**🆕 Recommendation:** Add HierarchyId column for performance

### 5. Policy Engine Domain

**Core Entities:**
- `Policies` - Print policies
- `PoliciesSettings` - Policy configuration
- `PoliciesControls*` - Policy controls for accounts/printers

**Complexity:** Very High - Complex rule evaluation engine

### 6. Quotas Domain

**Core Entities:**
- `QuotasRules` - Quota rules
- `QuotasCredits` - Credit balances
- `QuotasPrepaidCards*` - Prepaid card system
- `QuotasPayments` - Payment transactions

**Complexity:** High - Financial transactions, credit management

---

## EF Core Migration Strategy

### Phase 1: Foundation (Weeks 1-2)

**Upgrade & Setup:**
```bash
# Upgrade to EF Core 8
dotnet add package Microsoft.EntityFrameworkCore --version 8.0.*
dotnet add package Microsoft.EntityFrameworkCore.SqlServer --version 8.0.*
```

**Add HierarchyId:**
```csharp
public partial class AddCostAccountHierarchyPath : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.AddColumn<HierarchyId>(
            name: "HierarchyPath",
            table: "CostAccounts",
            nullable: false);
        
        // Populate from existing parent relationships
        migrationBuilder.Sql(@"/* CTE to populate HierarchyPath */");
        
        migrationBuilder.CreateIndex("IX_CostAccounts_HierarchyPath", "CostAccounts", "HierarchyPath");
    }
}
```

### Phase 2: Entity Layer (Weeks 3-4)

- ✅ Create all 205 entity classes
- ✅ Create all 205 entity configurations
- ✅ Configure all 184 foreign key relationships
- ✅ Configure indexes, constraints
- ✅ Generate sync migration

### Phase 3: Aggressive Conversion (Weeks 5-7)

**Week 5: Bulk Operations (~80 procedures)**
```csharp
// Convert all bulk update/delete procedures to ExecuteUpdate/ExecuteDelete
public class BulkOperationRepository
{
    public async Task<int> BulkUpdateAsync(List<int> ids, Action<SetPropertyBuilder> updates)
    {
        return await _context.SomeEntity
            .Where(e => ids.Contains(e.Id))
            .ExecuteUpdateAsync(updates);
    }
}
```

**Week 6: Hierarchical Operations (~50 procedures/functions)**
```csharp
// Convert hierarchy procedures to HierarchyId queries
public class CostAccountService
{
    public async Task<List<int>> GetDescendantsAsync(int rootId)
    {
        var root = await _context.CostAccounts.FindAsync(rootId);
        return await _context.CostAccounts
            .Where(ca => ca.HierarchyPath.IsDescendantOf(root.HierarchyPath))
            .Select(ca => ca.CostAccountID)
            .ToListAsync();
    }
}
```

**Week 7: Simple CRUD & Functions (~270 procedures + 50 functions)**
```csharp
// Standard repository methods
public class AccountRepository : IAccountRepository
{
    public async Task<Account?> GetByIdAsync(int id) => 
        await _context.Accounts.FindAsync(id);
    
    public async Task CreateAsync(Account account)
    {
        _context.Accounts.Add(account);
        await _context.SaveChangesAsync();
    }
    
    // ... etc
}
```

### Phase 4: Testing & Deployment (Weeks 8-10)

- Integration testing
- Performance testing (ensure ExecuteUpdate performs well)
- Load testing on hierarchical queries
- Production deployment

### Phase 5: Post-Launch (Ongoing)

- Monitor converted operation performance
- Gradually convert remaining procedures
- Optimize as needed

---

## Summary Statistics

### Database Composition

| Category | Count | Conversion Strategy |
|----------|-------|-------------------|
| **Tables** | 205 | ✅ 100% EF Core |
| **Procedures** | 684 | ✅ 58-66% convert, ❌ 34-42% keep |
| **Functions** | 73 | ✅ 68-75% convert, ❌ 25-32% keep |
| **Views** | 32 | Map as keyless, keep SQL |
| **Triggers** | 1 | ❌ Keep |
| **UDTs** | 6 | Create via SQL, eliminate usage |

### Overall Conversion (Modern EF Core 8+)

- **Total Objects:** 1,001+
- **Fully Convertible:** ~660-716 (66-71%)
- **Keep in SQL:** ~285-342 (29-34%)

### Key Success Factors

1. ✅ **Use EF Core 8+** (current LTS with all features)
2. ✅ **Add HierarchyId** to CostAccounts (critical!)
3. ✅ **Use ExecuteUpdate/ExecuteDelete** for bulk operations
4. ✅ **Use JSON columns** instead of UDTs
5. ✅ **Map views** as keyless entities
6. ✅ **Keep complex analytics** in SQL (pragmatic)

---

## Conclusion

Portal 360 is a **comprehensive enterprise print management system** with 1,001+ database objects spanning user management, device monitoring, job tracking, cost accounting, policy enforcement, and quota management.

**Modern EF Core (6-9) fundamentally changes the migration landscape:**
- Bulk operations are now viable (ExecuteUpdate)
- Hierarchical queries are now fast (HierarchyId)
- UDT usage can be eliminated (JSON columns)
- Complex queries work better (improved LINQ)

**Realistic target: 66-71% conversion** to modern, testable, maintainable C# code while keeping truly complex analytics and reporting in optimized SQL.

This is not just a database migration - it's a **strategic modernization** of a mature enterprise system using the latest EF Core capabilities.
