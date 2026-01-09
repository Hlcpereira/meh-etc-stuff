# Portal 360 Repository Implementation - Complete Guide

## Based on Your MarketplaceOrderRepository Pattern (CORRECTED)

This collection provides complete implementation guides for Portal 360's repository layer following your established architecture.

---

## 🔴 CRITICAL ARCHITECTURE RULES

### Rule #1: Services NEVER Know About DbContext

```csharp
// ❌ WRONG
public class AccountService
{
    private readonly Portal360DbContext _context; // NO!
}

// ✅ CORRECT  
public class AccountService
{
    private readonly IAccountRepository _accountRepository; // YES!
}
```

### Rule #2: Specifications Are for Joins AND Filters

Your `Spec<T>` combines both:
- **Predicate** - Filters (combined with AND)
- **Includes** - Joins (list of Include expressions)

### Rule #3: Repository Applies Spec, Not Service

```csharp
// ✅ CORRECT - In Repository
public async Task<List<Account>> GetBySpecAsync(AccountSpec spec)
{
    var query = _context.Accounts.AsQueryable();
    
    foreach (var include in spec.Includes)
        query = include(query);
    
    query = query.Where(spec.Predicate);
    
    return await query.AsNoTracking().ToListAsync();
}
```

---

## Documents Overview

### 1. Portal360_Repository_CORRECTED.md ⭐
**THE AUTHORITATIVE GUIDE - Start Here**

Shows all critical corrections:
- Services never access DbContext
- Specifications applied in repository layer
- Your exact Spec<T> implementation
- Complete working examples

**Use this as your primary reference!**

---

### 2. Portal360_Repository_Pattern_Implementation.md
**Your Pattern Applied to Portal 360**

Complete implementation following your exact architecture:
- Base Spec<T> with PredicateBuilder
- AccountSpec (like MarketplaceOrderSpec)
- AccountRepository (like MarketplaceOrderRepository)
- AccountService (calls repos, never context)
- BulkOperationRepository (ExecuteUpdate - EF7+)

**Updated with correct architecture!**

---

### 3. Portal360_Repository_Implementation_Guide.md  
**Extended Implementation Guide - Part 1**

Detailed guide covering:
- Base repository infrastructure
- IRepositoryBase, ICrudRepository, IQueryRepository
- Complete Repository<T> base class
- Specific repository patterns
- **CORRECTED:** Services never know context

---

### 4. Portal360_Repository_Implementation_Guide_Part2.md
**Extended Implementation Guide - Part 2**

Advanced topics:
- Hierarchy services (HierarchyId - EF8+)
- Controller examples (call services, not repos)
- Service layer (only knows repositories)
- Dependency injection setup
- Test examples
- **CORRECTED:** Proper layer separation

---

## Your Architecture Pattern

### Layer Responsibilities

```
Controller
    ↓ calls
Service (✅ knows repos, ❌ never context)
    ↓ builds spec & calls
Repository (✅ knows context, applies spec)
    ↓ uses
DbContext
```

### Your Spec<T> Implementation

```csharp
public class Spec<T> where T : class
{
    // Starts with true, ANDs all predicates
    public Expression<Func<T, bool>> Predicate { get; private set; } 
        = PredicateBuilder.True<T>();
    
    // List of includes to apply
    public List<Func<IQueryable<T>, IIncludableQueryable<T, object>>> Includes { get; } 
        = new();

    public void AddPredicate(Expression<Func<T, bool>> predicate)
    {
        Predicate = Predicate.And(predicate); // Uses PredicateBuilder
    }

    public Spec<T> Include(Func<IQueryable<T>, IIncludableQueryable<T, object>> include)
    {
        Includes.Add(include);
        return this;
    }
}
```

### Usage Pattern

```csharp
// Service builds spec
var spec = new AccountSpec()
    .ByDomainId(domainId)
    .ByIsActive(true)
    .ExcludeRemoved()
    .WithDomain()        // Include
    .WithCostAccount();  // Include

// Repository applies spec
return await _accountRepository.GetBySpecAsync(spec);
```

---

## Key Corrections Made

### ❌ What Was Wrong

1. Services had `DbContext` injected
2. Services called `_context.Accounts` directly
3. Specifications applied in service layer
4. Services knew about EF Core details

### ✅ What's Correct Now

1. **Only repositories know DbContext**
2. **Services only call repository methods**
3. **Specifications applied in repository layer**
4. **Services focus on business logic**

---

## File Structure

Following your pattern:

```
Portal360.Data/
├── Repositories/
│   ├── Base/
│   │   ├── IRepository.cs
│   │   └── Repository.cs
│   ├── AccountRepository.cs
│   ├── PrinterDeviceRepository.cs
│   ├── BulkOperationRepository.cs
│   └── ... (all repositories)
└── Portal360DbContext.cs

Portal360.Domain/
├── Entities/
├── Specifications/
│   ├── Spec.cs (base - your pattern)
│   ├── AccountSpec.cs
│   └── ... (all specs)
├── Filters/
│   ├── AccountFilter.cs
│   └── ... (all filters)
└── Contracts/
    └── Repositories/
        ├── IAccountRepository.cs
        └── ... (all interfaces)

Portal360.Application/
└── Services/
    ├── AccountService.cs (✅ no context!)
    └── ... (all services)
```

---

## Conversion Summary

### Pattern Mapping

| Your Pattern | Portal 360 | Count |
|--------------|------------|-------|
| MarketplaceOrderRepository | AccountRepository | ~400-450 |
| MarketplaceOrderSpec | AccountSpec | Same count |
| MarketplaceOrderService | AccountService | Same count |
| Spec<T> | Spec<T> | Exact same! |

### Repository Methods by Module

| Repository | Procedures → Methods |
|------------|---------------------|
| AccountRepository | ~25 procedures |
| PrinterDeviceRepository | ~30 procedures |
| PolicyRepository | ~15 procedures |
| CostAccountRepository | ~20 procedures |
| BulkOperationRepository | ~85 procedures |
| ... (others) | ~225 procedures |
| **TOTAL** | **~400-450 procedures** |

---

## Modern EF Core Features Added

### 🆕 ExecuteUpdate/ExecuteDelete (EF7+)

```csharp
// Fast bulk operations - no UDTs needed!
await _context.Accounts
    .Where(a => ids.Contains(a.AccountID))
    .ExecuteUpdateAsync(s => s.SetProperty(a => a.IsActive, false));
```

**Replaces 85+ bulk procedures!**

### 🆕 HierarchyId (EF8+)

```csharp
// Fast server-side hierarchical queries
return await _context.CostAccounts
    .Where(ca => ca.HierarchyPath.IsDescendantOf(root.HierarchyPath))
    .ToListAsync();
```

**Replaces ~50 hierarchical procedures!**

---

## Quick Start Guide

### Step 1: Read CORRECTED Guide First

```
📖 Portal360_Repository_CORRECTED.md
└─ Shows all critical architecture corrections
```

### Step 2: Review Your Pattern

```
Look at your files:
- MarketplaceOrderRepository.cs
- MarketplaceOrderSpec.cs  
- Spec.cs
- Repository.cs
```

### Step 3: Implement Portal 360

```
1. Copy Spec<T> (exact same as yours)
2. Create AccountSpec (like MarketplaceOrderSpec)
3. Create AccountRepository (applies spec, knows context)
4. Create AccountService (builds spec, calls repo, NO context)
5. Create BulkOperationRepository (ExecuteUpdate - new!)
```

---

## Critical Reminders

### ✅ DO

1. **Services call repositories** - Never access context
2. **Repositories apply specs** - Services build, repos execute
3. **Use PredicateBuilder.And()** - Chain predicates properly
4. **Specs handle filters AND joins** - Predicate + Includes
5. **Return materialized lists** - Not IQueryable

### ❌ DON'T

1. **Don't inject DbContext into services**
2. **Don't apply specs in service layer**
3. **Don't expose IQueryable from repositories**
4. **Don't mix data access with business logic**

---

## Dependency Injection

```csharp
// Program.cs

// DbContext - Infrastructure only
builder.Services.AddDbContext<Portal360DbContext>(...);

// Repositories - Only these know context
builder.Services.AddScoped<IAccountRepository, AccountRepository>();
builder.Services.AddScoped<IBulkOperationRepository, BulkOperationRepository>();

// Services - Never know context
builder.Services.AddScoped<IAccountService, AccountService>();
```

---

## Summary

### What You Have

✅ **Your exact architecture** - Spec<T>, repositories, services  
✅ **Modern EF Core** - ExecuteUpdate, HierarchyId, JSON  
✅ **Corrected implementation** - Services never know context  
✅ **Complete examples** - All 4 guides updated  
✅ **400-450 procedures** → Repository methods  

### What's Different

🆕 **ExecuteUpdate/Delete** - Fast bulk ops (replaces 85 procedures)  
🆕 **HierarchyId** - Server-side hierarchies (replaces 50 procedures)  
🔧 **Corrected layers** - Services NEVER access context  

---

**This is YOUR architecture, properly implemented for Portal 360!** 🎯
