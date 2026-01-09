# Portal 360 Repository Pattern Implementation Guide

## Based on Your Architecture Pattern (CORRECTED)

This guide shows how to implement Portal 360's repository layer following your established pattern from MarketplaceOrderRepository.

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

```csharp
public class Spec<T> where T : class
{
    // Combines predicates with AND
    public Expression<Func<T, bool>> Predicate { get; private set; } = PredicateBuilder.True<T>();
    
    // Builds includes list
    public List<Func<IQueryable<T>, IIncludableQueryable<T, object>>> Includes { get; } = new();
}
```

### Rule #3: Repository Applies Spec, Not Service

```csharp
// ✅ Repository applies specification
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

## Part 1: Base Specification (Your Exact Pattern)

```csharp
// Portal360.Domain/Specifications/Spec.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore.Query;

namespace Portal360.Domain.Specifications
{
    public class Spec<T> where T : class
    {
        // Starts with "true" predicate, then AND all predicates
        public Expression<Func<T, bool>> Predicate { get; private set; } = PredicateBuilder.True<T>();
        
        // List of includes to apply
        public List<Func<IQueryable<T>, IIncludableQueryable<T, object>>> Includes { get; } = new();

        // Helper for LIKE pattern
        public string ILikePattern(string value) => $"%{value}%";

        // Combines predicates with AND logic
        public void AddPredicate(Expression<Func<T, bool>> predicate)
        {
            Predicate = Predicate.And(predicate);
        }

        // Adds include to list
        public Spec<T> Include(Func<IQueryable<T>, IIncludableQueryable<T, object>> include)
        {
            Includes.Add(include);
            return this;
        }
    }

    // PredicateBuilder helper (from LinqKit or custom)
    public static class PredicateBuilder
    {
        public static Expression<Func<T, bool>> True<T>() => x => true;
        public static Expression<Func<T, bool>> False<T>() => x => false;

        public static Expression<Func<T, bool>> And<T>(
            this Expression<Func<T, bool>> first,
            Expression<Func<T, bool>> second)
        {
            var parameter = Expression.Parameter(typeof(T));

            var leftVisitor = new ReplaceExpressionVisitor(first.Parameters[0], parameter);
            var left = leftVisitor.Visit(first.Body);

            var rightVisitor = new ReplaceExpressionVisitor(second.Parameters[0], parameter);
            var right = rightVisitor.Visit(second.Body);

            return Expression.Lambda<Func<T, bool>>(
                Expression.AndAlso(left!, right!), parameter);
        }

        private class ReplaceExpressionVisitor : ExpressionVisitor
        {
            private readonly Expression _oldValue;
            private readonly Expression _newValue;

            public ReplaceExpressionVisitor(Expression oldValue, Expression newValue)
            {
                _oldValue = oldValue;
                _newValue = newValue;
            }

            public override Expression Visit(Expression node)
            {
                return node == _oldValue ? _newValue : base.Visit(node);
            }
        }
    }
}
```

---

## Part 2: Base Repository Infrastructure

### 2.1 IRepositoryBase<T>

```csharp
// Portal360.Data/Repositories/Base/IRepositoryBase.cs
using Microsoft.EntityFrameworkCore;

namespace Portal360.Data.Repositories.Base
{
    public interface IRepositoryBase<T> where T : class
    {
        Portal360DbContext DbContext { get; }
        
        // Helper methods for building queries
        // (CurrentSet implementations - similar to your pattern)
    }
}
```

### 2.2 IRepository<T> - Combines All Interfaces

```csharp
// Portal360.Data/Repositories/Base/IRepository.cs
namespace Portal360.Data.Repositories.Base
{
    public interface IRepository<T> :
        ICrudRepository<T>,
        IQueryRepository<T>,
        IQueryAsNoTrackingRepository<T>
        where T : class
    {
    }
}
```

### 2.3 Base Repository Implementation

```csharp
// Portal360.Data/Repositories/Base/Repository.cs
using Microsoft.EntityFrameworkCore;

namespace Portal360.Data.Repositories.Base
{
    public class Repository<T> : IRepository<T> where T : class
    {
        protected readonly Portal360DbContext _context;

        public Portal360DbContext DbContext => _context;

        public Repository(Portal360DbContext context)
        {
            _context = context;
        }

        // CRUD implementation
        public virtual void Add(T entity)
        {
            _context.Set<T>().Add(entity);
        }

        public virtual async Task AddAsync(T entity)
        {
            await _context.Set<T>().AddAsync(entity);
        }

        public virtual void Modify(T entity)
        {
            _context.Set<T>().Update(entity);
        }

        public virtual void Remove(T entity)
        {
            _context.Set<T>().Remove(entity);
        }

        // Query methods with AsNoTracking
        public virtual async Task<T> FindByKeyAsync(params object[] keyValues)
        {
            return await _context.Set<T>().FindAsync(keyValues);
        }

        public virtual async Task<int> CountAsync(Expression<Func<T, bool>> where = null)
        {
            where ??= (x => true);
            return await _context.Set<T>().CountAsync(where);
        }

        public virtual async Task<bool> AnyAsync(Expression<Func<T, bool>> where)
        {
            return await _context.Set<T>().AnyAsync(where);
        }
    }
}
```

---

## Part 3: AccountSpec (Like MarketplaceOrderSpec)

```csharp
// Portal360.Domain/Specifications/AccountSpec.cs
using System;
using Microsoft.EntityFrameworkCore;
using Portal360.Domain.Entities;
using Portal360.Domain.Filters;

namespace Portal360.Domain.Specifications
{
    public class AccountSpec : Spec<Account>
    {
        // Main filter method - like your ByFilter
        public AccountSpec ByFilter(AccountFilter filter)
        {
            if (filter.AccountId > 0)
                ByAccountId(filter.AccountId);

            if (!string.IsNullOrEmpty(filter.LogonName))
                ByLogonName(filter.LogonName);

            if (filter.DomainId > 0)
                ByDomainId(filter.DomainId);

            if (filter.CostAccountId.HasValue)
                ByCostAccountId(filter.CostAccountId.Value);

            if (filter.IsActive.HasValue)
                ByIsActive(filter.IsActive.Value);

            if (!filter.IncludeRemoved)
                ExcludeRemoved();

            return this;
        }

        // Filter predicates
        public AccountSpec ByAccountId(int accountId)
        {
            AddPredicate(a => a.AccountID == accountId);
            return this;
        }

        public AccountSpec ByLogonName(string logonName)
        {
            AddPredicate(a => a.LogonName.ToLower().Contains(logonName.ToLower()));
            return this;
        }

        public AccountSpec ByDomainId(int domainId)
        {
            AddPredicate(a => a.DomainID == domainId);
            return this;
        }

        public AccountSpec ByCostAccountId(int costAccountId)
        {
            AddPredicate(a => a.CostAccountID == costAccountId);
            return this;
        }

        public AccountSpec ByIsActive(bool isActive)
        {
            AddPredicate(a => a.IsActive == isActive);
            return this;
        }

        public AccountSpec ExcludeRemoved()
        {
            AddPredicate(a => !a.Removed);
            return this;
        }

        // Include methods - for joins
        public AccountSpec WithDomain()
        {
            Include(x => x.Include(a => a.Domain));
            return this;
        }

        public AccountSpec WithCostAccount()
        {
            Include(x => x.Include(a => a.CostAccount));
            return this;
        }

        public AccountSpec WithAliases()
        {
            Include(x => x.Include(a => a.AccountAliases));
            return this;
        }

        public AccountSpec WithFullDetails()
        {
            Include(x => x
                .Include(a => a.Domain)
                .Include(a => a.CostAccount)
                .Include(a => a.AccountAliases)
                .Include(a => a.Passport));
            return this;
        }
    }
}
```

---

## Part 4: Repository Interface & Implementation

### 4.1 IAccountRepository (No Context Exposure!)

```csharp
// Portal360.Domain/Contracts/Repositories/IAccountRepository.cs
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Portal360.Data.Repositories.Base;
using Portal360.Domain.Entities;
using Portal360.Domain.Specifications;

namespace Portal360.Domain.Contracts.Repositories
{
    public interface IAccountRepository : IRepository<Account>
    {
        // Converted from stored procedures
        Task<Account> GetByIdAsync(int accountId);
        Task<Account> GetByGuidAsync(Guid accountGuid);
        Task<List<Account>> GetByDomainAsync(int domainId);
        Task<List<Account>> SearchByNameAsync(string searchTerm);
        
        // Specification pattern - Repository applies spec
        Task<List<Account>> GetBySpecAsync(AccountSpec spec);
        Task<Account> GetFirstBySpecAsync(AccountSpec spec);
        Task<int> CountBySpecAsync(AccountSpec spec);
        
        // Bulk operations
        Task SoftDeleteAsync(int accountId);
    }
}
```

### 4.2 AccountRepository (Like MarketplaceOrderRepository)

```csharp
// Portal360.Data/Repositories/AccountRepository.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Portal360.Data.Repositories.Base;
using Portal360.Domain.Contracts.Repositories;
using Portal360.Domain.Entities;
using Portal360.Domain.Specifications;

namespace Portal360.Data.Repositories
{
    public class AccountRepository : Repository<Account>, IAccountRepository
    {
        public AccountRepository(Portal360DbContext context) : base(context)
        {
        }

        // proc_360_Accounts_RetrieveByID
        public async Task<Account> GetByIdAsync(int accountId)
        {
            return await _context.Accounts
                .Include(a => a.Domain)
                .Include(a => a.CostAccount)
                .AsNoTracking()
                .FirstOrDefaultAsync(a => a.AccountID == accountId);
        }

        // proc_360_Accounts_RetrieveByGuid
        public async Task<Account> GetByGuidAsync(Guid accountGuid)
        {
            return await _context.Accounts
                .Include(a => a.Domain)
                .Include(a => a.CostAccount)
                .AsNoTracking()
                .FirstOrDefaultAsync(a => a.AccountGuidId == accountGuid);
        }

        // proc_360_Accounts_RetrieveByDomain
        public async Task<List<Account>> GetByDomainAsync(int domainId)
        {
            return await _context.Accounts
                .Where(a => a.DomainID == domainId && !a.Removed)
                .Include(a => a.CostAccount)
                .AsNoTracking()
                .OrderBy(a => a.LogonName)
                .ToListAsync();
        }

        // proc_360_Accounts_SearchByName
        public async Task<List<Account>> SearchByNameAsync(string searchTerm)
        {
            return await _context.Accounts
                .Where(a => !a.Removed &&
                           (a.LogonName.Contains(searchTerm) ||
                            a.FullName != null && a.FullName.Contains(searchTerm)))
                .AsNoTracking()
                .Take(50)
                .OrderBy(a => a.LogonName)
                .ToListAsync();
        }

        // REPOSITORY APPLIES SPECIFICATION
        public async Task<List<Account>> GetBySpecAsync(AccountSpec spec)
        {
            var query = _context.Accounts.AsQueryable();
            
            // Apply includes from spec
            foreach (var include in spec.Includes)
            {
                query = include(query);
            }
            
            // Apply predicate from spec
            query = query.Where(spec.Predicate);
            
            return await query.AsNoTracking().ToListAsync();
        }

        public async Task<Account> GetFirstBySpecAsync(AccountSpec spec)
        {
            var query = _context.Accounts.AsQueryable();
            
            foreach (var include in spec.Includes)
            {
                query = include(query);
            }
            
            query = query.Where(spec.Predicate);
            
            return await query.AsNoTracking().FirstOrDefaultAsync();
        }

        public async Task<int> CountBySpecAsync(AccountSpec spec)
        {
            // For count, don't need includes
            return await _context.Accounts
                .Where(spec.Predicate)
                .CountAsync();
        }

        // proc_360_Accounts_Remove (ExecuteUpdate - EF7+)
        public async Task SoftDeleteAsync(int accountId)
        {
            await _context.Accounts
                .Where(a => a.AccountID == accountId)
                .ExecuteUpdateAsync(s => s
                    .SetProperty(a => a.Removed, true)
                    .SetProperty(a => a.ChangedDate, DateTime.UtcNow));
        }
    }
}
```

---

## Part 5: Service Layer (NO Context!)

```csharp
// Portal360.Application/Services/AccountService.cs
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Portal360.Domain.Contracts.Repositories;
using Portal360.Domain.Entities;
using Portal360.Domain.Specifications;

namespace Portal360.Application.Services
{
    public class AccountService : IAccountService
    {
        // ✅ Service only knows repositories - NO CONTEXT!
        private readonly IAccountRepository _accountRepository;
        private readonly IBulkOperationRepository _bulkOperationRepository;

        public AccountService(
            IAccountRepository accountRepository,
            IBulkOperationRepository bulkOperationRepository)
        {
            _accountRepository = accountRepository;
            _bulkOperationRepository = bulkOperationRepository;
        }

        public async Task<Account> GetAccountByIdAsync(int accountId)
        {
            return await _accountRepository.GetByIdAsync(accountId);
        }

        public async Task<List<Account>> GetActiveAccountsInDomainAsync(int domainId)
        {
            // Service builds specification
            var spec = new AccountSpec()
                .ByDomainId(domainId)
                .ByIsActive(true)
                .ExcludeRemoved()
                .WithDomain()
                .WithCostAccount();

            // Repository applies spec
            return await _accountRepository.GetBySpecAsync(spec);
        }

        public async Task<List<Account>> SearchAccountsAsync(
            string searchTerm, 
            int? domainId = null)
        {
            var spec = new AccountSpec()
                .ByLogonName(searchTerm)
                .ExcludeRemoved()
                .WithDomain();

            if (domainId.HasValue)
                spec.ByDomainId(domainId.Value);

            return await _accountRepository.GetBySpecAsync(spec);
        }

        public async Task<int> DisableAccountsAsync(List<int> accountIds)
        {
            return await _bulkOperationRepository.BulkDisableAccountsAsync(accountIds);
        }
    }
}
```

---

## Part 6: Bulk Operations Repository

```csharp
// Portal360.Domain/Contracts/Repositories/IBulkOperationRepository.cs
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Portal360.Domain.Contracts.Repositories
{
    public interface IBulkOperationRepository
    {
        Task<int> BulkDisableAccountsAsync(List<int> accountIds);
        Task<int> BulkEnableAccountsAsync(List<int> accountIds);
        Task<int> BulkUpdateCostAccountAsync(List<int> accountIds, int newCostAccountId);
        Task<int> BulkRemoveAccountsAsync(List<int> accountIds);
    }
}
```

```csharp
// Portal360.Data/Repositories/BulkOperationRepository.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Portal360.Domain.Contracts.Repositories;

namespace Portal360.Data.Repositories
{
    public class BulkOperationRepository : IBulkOperationRepository
    {
        private readonly Portal360DbContext _context;

        public BulkOperationRepository(Portal360DbContext context)
        {
            _context = context;
        }

        // proc_360_Accounts_BulkDisable
        public async Task<int> BulkDisableAccountsAsync(List<int> accountIds)
        {
            return await _context.Accounts
                .Where(a => accountIds.Contains(a.AccountID))
                .ExecuteUpdateAsync(s => s
                    .SetProperty(a => a.IsActive, false)
                    .SetProperty(a => a.ChangedDate, DateTime.UtcNow));
        }

        // proc_360_Accounts_BulkEnable
        public async Task<int> BulkEnableAccountsAsync(List<int> accountIds)
        {
            return await _context.Accounts
                .Where(a => accountIds.Contains(a.AccountID))
                .ExecuteUpdateAsync(s => s
                    .SetProperty(a => a.IsActive, true)
                    .SetProperty(a => a.ChangedDate, DateTime.UtcNow));
        }

        // proc_360_Accounts_BulkUpdateCostAccount
        public async Task<int> BulkUpdateCostAccountAsync(List<int> accountIds, int newCostAccountId)
        {
            return await _context.Accounts
                .Where(a => accountIds.Contains(a.AccountID))
                .ExecuteUpdateAsync(s => s
                    .SetProperty(a => a.CostAccountID, newCostAccountId)
                    .SetProperty(a => a.ChangedDate, DateTime.UtcNow));
        }

        // proc_360_Accounts_BulkRemove
        public async Task<int> BulkRemoveAccountsAsync(List<int> accountIds)
        {
            return await _context.Accounts
                .Where(a => accountIds.Contains(a.AccountID))
                .ExecuteUpdateAsync(s => s
                    .SetProperty(a => a.Removed, true)
                    .SetProperty(a => a.ChangedDate, DateTime.UtcNow));
        }
    }
}
```

---

## Dependency Injection

```csharp
// Program.cs
var builder = WebApplication.CreateBuilder(args);

// DbContext - Only infrastructure knows this
builder.Services.AddDbContext<Portal360DbContext>(options =>
{
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("Portal360"),
        sqlOptions => sqlOptions.UseHierarchyId());
});

// Repositories - Only these know DbContext
builder.Services.AddScoped<IAccountRepository, AccountRepository>();
builder.Services.AddScoped<IBulkOperationRepository, BulkOperationRepository>();

// Services - Never know DbContext
builder.Services.AddScoped<IAccountService, AccountService>();

var app = builder.Build();
app.Run();
```

---

## Architecture Layers

```
┌─────────────────────────────────────────┐
│          Controllers                     │
│  (Calls services, never repositories)   │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│            Services                      │
│  • Builds specifications                │
│  • Calls repository methods              │
│  • Orchestrates business logic          │
│  • ❌ NEVER accesses DbContext          │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│          Repositories                    │
│  • Applies specifications                │
│  • Executes queries                      │
│  • ✅ ONLY layer that knows DbContext   │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│           DbContext                      │
│  (EF Core, Database)                    │
└──────────────────────────────────────────┘
```

---

## Summary

### Your Pattern Applied to Portal 360

| Your Pattern | Portal 360 |
|--------------|------------|
| MarketplaceOrderRepository | AccountRepository |
| MarketplaceOrderSpec | AccountSpec |
| MarketplaceOrderService | AccountService |
| Spec<T> | Spec<T> (exact same!) |
| Repository<T> | Repository<T> |

### Key Principles

✅ **Services never know DbContext** - Only repositories  
✅ **Specifications for filters AND joins** - Predicate + Includes  
✅ **Repository applies spec** - Not service  
✅ **Return materialized lists** - Not IQueryable  
✅ **PredicateBuilder.And()** - Chain predicates properly  

**This is 100% your architecture!** 🎯
