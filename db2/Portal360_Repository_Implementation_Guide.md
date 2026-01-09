# Portal 360 Repository Implementation Guide
## Based on Modern Repository Pattern

---

## Table of Contents
1. [Architecture Overview](#architecture-overview)
2. [Base Repository Infrastructure](#base-repository-infrastructure)
3. [Specific Repository Implementations](#specific-repository-implementations)
4. [Specification Pattern](#specification-pattern)
5. [Bulk Operations Repository](#bulk-operations-repository)
6. [Hierarchy Services](#hierarchy-services)
7. [Complete Examples](#complete-examples)

---

## Architecture Overview

### Layered Structure

```
Portal360.Domain/
├── Contracts/
│   ├── Repositories/
│   │   ├── IRepository.cs
│   │   ├── IRepositoryBase.cs
│   │   ├── ICrudRepository.cs
│   │   ├── IQueryRepository.cs
│   │   ├── IQueryAsNoTrackingRepository.cs
│   │   ├── IBulkOperationRepository.cs
│   │   ├── IAccountRepository.cs
│   │   ├── IPrinterDeviceRepository.cs
│   │   └── ... (all specific repositories)
│   └── Services/
│       ├── IAccountService.cs
│       └── ... (business logic services)
├── Entities/
├── Specifications/
│   ├── Specification.cs (base)
│   ├── AccountSpec.cs
│   ├── PrinterDeviceSpec.cs
│   └── ... (all specifications)
└── Filters/
    ├── AccountFilter.cs
    ├── PrinterDeviceFilter.cs
    └── ... (all filters)

Portal360.Data/
├── Repositories/
│   ├── Repository.cs (base implementation)
│   ├── AccountRepository.cs
│   ├── PrinterDeviceRepository.cs
│   ├── BulkOperationRepository.cs
│   └── ... (all implementations)
└── Portal360DbContext.cs
```

---

## Base Repository Infrastructure

### 1. IRepositoryBase<T>

```csharp
// Domain/Contracts/Repositories/IRepositoryBase.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;

namespace Portal360.Domain.Contracts.Repositories
{
    public interface IRepositoryBase<T> where T : class
    {
        Portal360DbContext Context { get; }

        protected IQueryable<T> CurrentSet(
            Expression<Func<T, bool>> where = null,
            int? page = null,
            int? pageSize = null,
            string sortField = null,
            string sortType = null,
            IEnumerable<string> includes = null)
        {
            IQueryable<T> currentSet = Context.Set<T>();

            where ??= (x => true);

            // Apply includes
            if (includes != null)
            {
                currentSet = includes
                    .Where(include => !string.IsNullOrEmpty(include))
                    .Aggregate(currentSet, (current, include) => current.Include(include));
            }

            // Apply where clause
            currentSet = currentSet.Where(where);

            // Apply sorting
            if (!string.IsNullOrEmpty(sortField) && !string.IsNullOrEmpty(sortType))
            {
                var order = string.Join(",",
                    sortField.Split(",")
                        .Select(x => x.Trim())
                        .Where(x => !string.IsNullOrWhiteSpace(x))
                        .Select(x => $"{x} {sortType}")
                        .ToArray());
                currentSet = currentSet.OrderBy(order);
            }

            // Apply pagination
            if (page != null && pageSize != null)
            {
                currentSet = currentSet
                    .Skip((page.Value - 1) * pageSize.Value)
                    .Take(pageSize.Value);
            }

            return currentSet;
        }

        protected IQueryable<T> CurrentSet(
            Expression<Func<T, bool>> where = null,
            int? page = null,
            int? pageSize = null,
            string sortField = null,
            string sortType = null,
            params Expression<Func<T, object>>[] includes)
        {
            IQueryable<T> currentSet = Context.Set<T>();

            where ??= (x => true);

            // Apply includes
            if (includes != null && includes.Any())
            {
                currentSet = includes.Aggregate(currentSet, 
                    (current, include) => current.Include(include));
            }

            // Apply where clause
            currentSet = currentSet.Where(where);

            // Apply sorting
            if (!string.IsNullOrEmpty(sortField) && !string.IsNullOrEmpty(sortType))
            {
                var order = string.Join(",",
                    sortField.Split(",")
                        .Select(x => x.Trim())
                        .Where(x => !string.IsNullOrWhiteSpace(x))
                        .Select(x => $"{x} {sortType}")
                        .ToArray());
                currentSet = currentSet.OrderBy(order);
            }

            // Apply pagination
            if (page != null && pageSize != null)
            {
                currentSet = currentSet
                    .Skip((page.Value - 1) * pageSize.Value)
                    .Take(pageSize.Value);
            }

            return currentSet;
        }

        protected IQueryable<T> CurrentSet(
            List<Func<IQueryable<T>, IIncludableQueryable<T, object>>> includes,
            Expression<Func<T, bool>> where = null,
            string sortField = null,
            string sortType = null,
            int? page = null,
            int? pageSize = null)
        {
            IQueryable<T> currentSet = Context.Set<T>();

            where ??= (x => true);

            // Apply includes
            if (includes != null && includes.Any())
            {
                currentSet = includes.Aggregate(currentSet, 
                    (current, include) => include(current));
            }

            // Apply where clause
            currentSet = currentSet.Where(where);

            // Apply sorting
            if (!string.IsNullOrEmpty(sortField) && !string.IsNullOrEmpty(sortType))
            {
                var order = string.Join(",",
                    sortField.Split(",")
                        .Select(x => x.Trim())
                        .Where(x => !string.IsNullOrWhiteSpace(x))
                        .Select(x => $"{x} {sortType}")
                        .ToArray());
                currentSet = currentSet.OrderBy(order);
            }

            // Apply pagination
            if (page != null && pageSize != null)
            {
                currentSet = currentSet
                    .Skip((page.Value - 1) * pageSize.Value)
                    .Take(pageSize.Value);
            }

            return currentSet;
        }
    }
}
```

### 2. ICrudRepository<T>

```csharp
// Domain/Contracts/Repositories/ICrudRepository.cs
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Portal360.Domain.Contracts.Repositories
{
    public interface ICrudRepository<T> : IRepositoryBase<T> where T : class
    {
        void Add(T entity);
        Task AddAsync(T entity);
        void Modify(T entity);
        void Remove(T entity);
        void AddRange(IEnumerable<T> entities);
        Task AddRangeAsync(IEnumerable<T> entities);
    }
}
```

**Default Implementation:**

```csharp
// Domain/Contracts/Repositories/ICrudRepository.cs (with default interface methods)
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Portal360.Domain.Contracts.Repositories
{
    public interface ICrudRepository<T> : IRepositoryBase<T> where T : class
    {
        public virtual void Add(T entity)
        {
            Context.Set<T>().Add(entity);
        }

        public virtual async Task AddAsync(T entity)
        {
            await Context.Set<T>().AddAsync(entity);
        }

        public virtual void Modify(T entity)
        {
            Context.Set<T>().Update(entity);
        }

        public virtual void Remove(T entity)
        {
            Context.Set<T>().Remove(entity);
        }

        public virtual void AddRange(IEnumerable<T> entities)
        {
            Context.Set<T>().AddRange(entities);
        }

        public virtual async Task AddRangeAsync(IEnumerable<T> entities)
        {
            await Context.Set<T>().AddRangeAsync(entities);
        }
    }
}
```

### 3. IQueryRepository<T>

```csharp
// Domain/Contracts/Repositories/IQueryRepository.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Portal360.Domain.Common;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;

namespace Portal360.Domain.Contracts.Repositories
{
    public interface IQueryRepository<T> : IRepositoryBase<T> where T : class
    {
        // Count
        public virtual int Count(Expression<Func<T, bool>> where = null)
        {
            where ??= (x => true);
            return Context.Set<T>().Count(where);
        }

        public virtual Task<int> CountAsync(Expression<Func<T, bool>> where = null)
        {
            where ??= (x => true);
            return Context.Set<T>().CountAsync(where);
        }

        // Any
        public virtual bool Any(Expression<Func<T, bool>> where)
        {
            return Context.Set<T>().Any(where);
        }

        public virtual Task<bool> AnyAsync(Expression<Func<T, bool>> where)
        {
            return Context.Set<T>().AnyAsync(where);
        }

        // Find by key
        public virtual T FindByKey(params object[] keyValues)
        {
            return Context.Set<T>().Find(keyValues);
        }

        public virtual ValueTask<T> FindByKeyAsync(params object[] keyValues)
        {
            return Context.Set<T>().FindAsync(keyValues);
        }

        // Find
        public virtual T Find(
            Expression<Func<T, bool>> where, 
            IEnumerable<string> includes = null)
        {
            return CurrentSet(includes: includes).FirstOrDefault(where);
        }

        public virtual Task<T> FindAsync(
            Expression<Func<T, bool>> where, 
            IEnumerable<string> includes = null)
        {
            return CurrentSet(includes: includes).FirstOrDefaultAsync(where);
        }

        public virtual T Find(
            Expression<Func<T, bool>> where, 
            params Expression<Func<T, object>>[] includes)
        {
            return CurrentSet(includes: includes).FirstOrDefault(where);
        }

        public virtual Task<T> FindAsync(
            Expression<Func<T, bool>> where,
            params Expression<Func<T, object>>[] includes)
        {
            return CurrentSet(includes: includes).FirstOrDefaultAsync(where);
        }

        // List
        public virtual IQueryable<T> List(IEnumerable<string> includes = null)
        {
            return CurrentSet(includes: includes);
        }

        public virtual IQueryable<T> List(params Expression<Func<T, object>>[] includes)
        {
            return CurrentSet(includes: includes);
        }

        public virtual IQueryable<T> List(
            Expression<Func<T, bool>> where = null,
            int? page = null,
            int? pageSize = null,
            string sortField = null,
            string sortType = null,
            IEnumerable<string> includes = null)
        {
            return CurrentSet(where, page, pageSize, sortField, sortType, includes);
        }

        public virtual IQueryable<T> List(
            Expression<Func<T, bool>> where = null,
            int? page = null,
            int? pageSize = null,
            string sortField = null,
            string sortType = null,
            params Expression<Func<T, object>>[] includes)
        {
            return CurrentSet(where, page, pageSize, sortField, sortType, includes);
        }

        public virtual IQueryable<T> List(
            Expression<Func<T, bool>> where, 
            IPagination pagination, 
            IEnumerable<string> includes = null)
        {
            return CurrentSet(where,
                pagination.PageIndex,
                pagination.PageSize,
                pagination.SortField,
                pagination.SortType,
                includes);
        }

        public virtual IQueryable<T> List(
            Expression<Func<T, bool>> where, 
            IPagination pagination, 
            params Expression<Func<T, object>>[] includes)
        {
            return CurrentSet(where,
                pagination.PageIndex,
                pagination.PageSize,
                pagination.SortField,
                pagination.SortType,
                includes);
        }

        // Paged List
        public virtual PagedList<T> PagedList(
            Expression<Func<T, bool>> where, 
            IPagination pagination, 
            params Expression<Func<T, object>>[] includes)
        {
            var total = Count(where);
            var items = List(where, pagination, includes);
            return new PagedList<T>(items, total, pagination.PageSize);
        }
    }
}
```

### 4. IQueryAsNoTrackingRepository<T>

```csharp
// Domain/Contracts/Repositories/IQueryAsNoTrackingRepository.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Portal360.Domain.Common;
using Microsoft.EntityFrameworkCore;

namespace Portal360.Domain.Contracts.Repositories
{
    public interface IQueryAsNoTrackingRepository<T> : IRepositoryBase<T> where T : class
    {
        // Find
        public virtual T FindAsNoTracking(
            Expression<Func<T, bool>> where, 
            IEnumerable<string> includes = null)
        {
            return CurrentSet(includes: includes).AsNoTracking().FirstOrDefault(where);
        }

        public virtual Task<T> FindAsNoTrackingAsync(
            Expression<Func<T, bool>> where,
            IEnumerable<string> includes = null)
        {
            return CurrentSet(includes: includes).AsNoTracking().FirstOrDefaultAsync(where);
        }

        public virtual T FindAsNoTracking(
            Expression<Func<T, bool>> where, 
            params Expression<Func<T, object>>[] includes)
        {
            return CurrentSet(includes: includes).AsNoTracking().FirstOrDefault(where);
        }

        public virtual Task<T> FindAsNoTrackingAsync(
            Expression<Func<T, bool>> where,
            params Expression<Func<T, object>>[] includes)
        {
            return CurrentSet(includes: includes).AsNoTracking().FirstOrDefaultAsync(where);
        }

        // List
        public virtual IQueryable<T> ListAsNoTracking(
            Expression<Func<T, bool>> where = null,
            int? page = null,
            int? pageSize = null,
            string sortField = null,
            string sortType = null,
            IEnumerable<string> includes = null)
        {
            return CurrentSet(where, page, pageSize, sortField, sortType, includes)
                .AsNoTracking();
        }

        public virtual IQueryable<T> ListAsNoTracking(
            Expression<Func<T, bool>> where = null,
            int? page = null,
            int? pageSize = null,
            string sortField = null,
            string sortType = null,
            params Expression<Func<T, object>>[] includes)
        {
            return CurrentSet(where, page, pageSize, sortField, sortType, includes)
                .AsNoTracking();
        }

        public virtual IQueryable<T> ListAsNoTracking(
            Expression<Func<T, bool>> where, 
            IPagination pagination, 
            IEnumerable<string> includes = null)
        {
            return ListAsNoTracking(where, 
                pagination.PageIndex, 
                pagination.PageSize, 
                pagination.SortField, 
                pagination.SortType, 
                includes);
        }

        public virtual IQueryable<T> ListAsNoTracking(
            Expression<Func<T, bool>> where, 
            IPagination pagination, 
            params Expression<Func<T, object>>[] includes)
        {
            return ListAsNoTracking(where, 
                pagination.PageIndex, 
                pagination.PageSize, 
                pagination.SortField, 
                pagination.SortType, 
                includes);
        }

        // Paged List
        public virtual PagedList<T> PagedListAsNoTracking(
            Expression<Func<T, bool>> where, 
            IPagination pagination, 
            params Expression<Func<T, object>>[] includes)
        {
            var total = Context.Set<T>().Count(where);
            var items = ListAsNoTracking(where, pagination, includes);
            return new PagedList<T>(items, total, pagination.PageSize);
        }
    }
}
```

### 5. IRepository<T> - Combines All

```csharp
// Domain/Contracts/Repositories/IRepository.cs
namespace Portal360.Domain.Contracts.Repositories
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

### 6. Base Repository Implementation

```csharp
// Data/Repositories/Repository.cs
using Portal360.Domain.Contracts.Repositories;
using Portal360.Data;

namespace Portal360.Data.Repositories
{
    public class Repository<T> : IRepository<T> where T : class
    {
        protected readonly Portal360DbContext _context;

        public Portal360DbContext Context => _context;

        public Repository(Portal360DbContext context)
        {
            _context = context;
        }
    }
}
```

---

## Specific Repository Implementations

### Example 1: Account Repository

```csharp
// Domain/Contracts/Repositories/IAccountRepository.cs
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Portal360.Domain.Entities;
using Portal360.Domain.Filters;

namespace Portal360.Domain.Contracts.Repositories
{
    public interface IAccountRepository : IRepository<Account>
    {
        // Converted from proc_360_Accounts_RetrieveByID
        Task<Account> GetByIdAsync(int accountId);
        
        // Converted from proc_360_Accounts_RetrieveByGuid
        Task<Account> GetByGuidAsync(Guid accountGuid);
        
        // Converted from proc_360_Accounts_RetrieveByDomain
        Task<List<Account>> GetByDomainAsync(int domainId);
        
        // Converted from proc_360_Accounts_SearchByName
        Task<List<Account>> SearchByNameAsync(string searchTerm);
        
        // Converted from proc_360_Accounts_RetrieveByCostAccount
        Task<List<Account>> GetByCostAccountAsync(int costAccountId);
        
        // Converted from proc_360_Accounts_RetrieveActive
        Task<List<Account>> GetActiveAccountsAsync();
        
        // Using filter + specification
        Task<List<Account>> GetByFilterAsync(AccountFilter filter);
        
        // Soft delete - converted from proc_360_Accounts_Remove
        Task SoftDeleteAsync(int accountId);
    }
}
```

```csharp
// Data/Repositories/AccountRepository.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Portal360.Domain.Contracts.Repositories;
using Portal360.Domain.Entities;
using Portal360.Domain.Filters;
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
                .Include(a => a.Passport)
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
                .OrderBy(a => a.LogonName)
                .AsNoTracking()
                .ToListAsync();
        }

        // proc_360_Accounts_SearchByName
        public async Task<List<Account>> SearchByNameAsync(string searchTerm)
        {
            return await _context.Accounts
                .Where(a => !a.Removed &&
                           (a.LogonName.Contains(searchTerm) ||
                            a.FullName != null && a.FullName.Contains(searchTerm)))
                .Include(a => a.Domain)
                .OrderBy(a => a.LogonName)
                .Take(50)
                .AsNoTracking()
                .ToListAsync();
        }

        // proc_360_Accounts_RetrieveByCostAccount
        public async Task<List<Account>> GetByCostAccountAsync(int costAccountId)
        {
            return await _context.Accounts
                .Where(a => a.CostAccountID == costAccountId && !a.Removed)
                .Include(a => a.Domain)
                .Include(a => a.CostAccount)
                .OrderBy(a => a.LogonName)
                .AsNoTracking()
                .ToListAsync();
        }

        // proc_360_Accounts_RetrieveActive
        public async Task<List<Account>> GetActiveAccountsAsync()
        {
            return await _context.Accounts
                .Where(a => a.IsActive && !a.Removed)
                .OrderBy(a => a.LogonName)
                .AsNoTracking()
                .ToListAsync();
        }

        // Using Specification Pattern
        public async Task<List<Account>> GetByFilterAsync(AccountFilter filter)
        {
            var spec = new AccountSpec().ByFilter(filter);
            
            var query = _context.Accounts.AsQueryable();
            
            // Apply specification
            query = spec.Apply(query);
            
            return await query
                .AsNoTracking()
                .ToListAsync();
        }

        // proc_360_Accounts_Remove (soft delete using ExecuteUpdate - EF7+)
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

### Example 2: Printer Device Repository

```csharp
// Domain/Contracts/Repositories/IPrinterDeviceRepository.cs
using System.Collections.Generic;
using System.Threading.Tasks;
using Portal360.Domain.Entities;
using Portal360.Domain.Filters;

namespace Portal360.Domain.Contracts.Repositories
{
    public interface IPrinterDeviceRepository : IRepository<PrinterDevice>
    {
        Task<PrinterDevice> GetByIdAsync(long printerDeviceId);
        Task<List<PrinterDevice>> GetByMachineIdAsync(long machineId);
        Task<List<PrinterDevice>> GetByCostAccountAsync(int costAccountId);
        Task<List<PrinterDevice>> GetActiveDevicesAsync();
        Task<List<PrinterDevice>> GetConsolidatedPrintersAsync();
        Task<List<PrinterDevice>> GetByFilterAsync(PrinterDeviceFilter filter);
    }
}
```

```csharp
// Data/Repositories/PrinterDeviceRepository.cs
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Portal360.Domain.Contracts.Repositories;
using Portal360.Domain.Entities;
using Portal360.Domain.Filters;
using Portal360.Domain.Specifications;

namespace Portal360.Data.Repositories
{
    public class PrinterDeviceRepository : Repository<PrinterDevice>, IPrinterDeviceRepository
    {
        public PrinterDeviceRepository(Portal360DbContext context) : base(context)
        {
        }

        // proc_360_PrintersDevices_RetrieveByID
        public async Task<PrinterDevice> GetByIdAsync(long printerDeviceId)
        {
            return await _context.PrintersDevices
                .Include(pd => pd.Machine)
                .Include(pd => pd.PrinterModel)
                    .ThenInclude(pm => pm.PrinterBrand)
                .Include(pd => pd.CostAccount)
                .AsNoTracking()
                .FirstOrDefaultAsync(pd => pd.PrinterDeviceID == printerDeviceId);
        }

        // proc_360_PrintersDevices_RetrieveByMachine
        public async Task<List<PrinterDevice>> GetByMachineIdAsync(long machineId)
        {
            return await _context.PrintersDevices
                .Where(pd => pd.MachineID == machineId && pd.IsActive)
                .Include(pd => pd.PrinterModel)
                .OrderBy(pd => pd.PrinterQueueName)
                .AsNoTracking()
                .ToListAsync();
        }

        // proc_360_PrintersDevices_RetrieveByCostAccount
        public async Task<List<PrinterDevice>> GetByCostAccountAsync(int costAccountId)
        {
            return await _context.PrintersDevices
                .Where(pd => pd.CostAccountID == costAccountId && pd.IsActive)
                .Include(pd => pd.Machine)
                .Include(pd => pd.PrinterModel)
                .OrderBy(pd => pd.PrinterQueueName)
                .AsNoTracking()
                .ToListAsync();
        }

        // proc_360_PrintersDevices_RetrieveActive
        public async Task<List<PrinterDevice>> GetActiveDevicesAsync()
        {
            return await _context.PrintersDevices
                .Where(pd => pd.IsActive && pd.Machine.IsActive)
                .Include(pd => pd.Machine)
                .Include(pd => pd.PrinterModel)
                .OrderBy(pd => pd.PrinterQueueName)
                .AsNoTracking()
                .ToListAsync();
        }

        // proc_360_PrintersDevices_RetrieveConsolidated
        public async Task<List<PrinterDevice>> GetConsolidatedPrintersAsync()
        {
            return await _context.PrintersDevices
                .Where(pd => pd.PrinterDeviceID != pd.RealPrinterDeviceID && pd.IsActive)
                .Include(pd => pd.RealPrinterDevice)
                .Include(pd => pd.Machine)
                .AsNoTracking()
                .ToListAsync();
        }

        public async Task<List<PrinterDevice>> GetByFilterAsync(PrinterDeviceFilter filter)
        {
            var spec = new PrinterDeviceSpec().ByFilter(filter);
            
            var query = _context.PrintersDevices.AsQueryable();
            query = spec.Apply(query);
            
            return await query.AsNoTracking().ToListAsync();
        }
    }
}
```

---

## Specification Pattern

### Base Specification Class

```csharp
// Domain/Specifications/Specification.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;

namespace Portal360.Domain.Specifications
{
    public abstract class Specification<T> where T : class
    {
        private readonly List<Expression<Func<T, bool>>> _predicates = new();
        private readonly List<Func<IQueryable<T>, IIncludableQueryable<T, object>>> _includes = new();
        private readonly List<string> _includeStrings = new();
        private Func<IQueryable<T>, IOrderedQueryable<T>> _orderBy;
        private int? _take;
        private int? _skip;

        protected void AddPredicate(Expression<Func<T, bool>> predicate)
        {
            _predicates.Add(predicate);
        }

        protected void AddInclude(Expression<Func<T, object>> include)
        {
            _includes.Add(query => query.Include(include));
        }

        protected void AddInclude(Func<IQueryable<T>, IIncludableQueryable<T, object>> include)
        {
            _includes.Add(include);
        }

        protected void AddInclude(string includeString)
        {
            _includeStrings.Add(includeString);
        }

        protected void ApplyOrderBy(Func<IQueryable<T>, IOrderedQueryable<T>> orderBy)
        {
            _orderBy = orderBy;
        }

        protected void ApplyPaging(int skip, int take)
        {
            _skip = skip;
            _take = take;
        }

        public IQueryable<T> Apply(IQueryable<T> query)
        {
            // Apply includes
            foreach (var include in _includes)
            {
                query = include(query);
            }

            foreach (var includeString in _includeStrings)
            {
                query = query.Include(includeString);
            }

            // Apply predicates
            foreach (var predicate in _predicates)
            {
                query = query.Where(predicate);
            }

            // Apply ordering
            if (_orderBy != null)
            {
                query = _orderBy(query);
            }

            // Apply paging
            if (_skip.HasValue)
            {
                query = query.Skip(_skip.Value);
            }

            if (_take.HasValue)
            {
                query = query.Take(_take.Value);
            }

            return query;
        }

        public Expression<Func<T, bool>> ToExpression()
        {
            if (!_predicates.Any())
            {
                return x => true;
            }

            var firstPredicate = _predicates.First();
            var combined = _predicates.Skip(1)
                .Aggregate(firstPredicate, (current, predicate) =>
                {
                    var parameter = Expression.Parameter(typeof(T));
                    var left = Expression.Invoke(current, parameter);
                    var right = Expression.Invoke(predicate, parameter);
                    var body = Expression.AndAlso(left, right);
                    return Expression.Lambda<Func<T, bool>>(body, parameter);
                });

            return combined;
        }
    }
}
```

### Account Specification

```csharp
// Domain/Specifications/AccountSpec.cs
using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Portal360.Domain.Entities;
using Portal360.Domain.Filters;
using Portal360.Domain.ValueObjects;

namespace Portal360.Domain.Specifications
{
    public class AccountSpec : Specification<Account>
    {
        public AccountSpec ByFilter(AccountFilter filter)
        {
            if (filter.AccountId != 0)
                ByAccountId(filter.AccountId);

            if (filter.AccountGuid != Guid.Empty)
                ByAccountGuid(filter.AccountGuid);

            if (!string.IsNullOrEmpty(filter.LogonName))
                ByLogonName(filter.LogonName);

            if (!string.IsNullOrEmpty(filter.Email))
                ByEmail(filter.Email);

            if (filter.DomainId != 0)
                ByDomainId(filter.DomainId);

            if (filter.CostAccountId.HasValue)
                ByCostAccountId(filter.CostAccountId.Value);

            if (filter.IsActive.HasValue)
                ByIsActive(filter.IsActive.Value);

            if (!filter.IncludeRemoved)
                ExcludeRemoved();

            if (filter.CreatedDateRange != null)
                ByCreatedDateRange(filter.CreatedDateRange);

            return this;
        }

        public AccountSpec ByAccountId(int accountId)
        {
            AddPredicate(a => a.AccountID == accountId);
            return this;
        }

        public AccountSpec ByAccountGuid(Guid accountGuid)
        {
            AddPredicate(a => a.AccountGuidId == accountGuid);
            return this;
        }

        public AccountSpec ByLogonName(string logonName)
        {
            AddPredicate(a => a.LogonName.ToLower().Contains(logonName.ToLower()));
            return this;
        }

        public AccountSpec ByEmail(string email)
        {
            AddPredicate(a => a.Email != null && a.Email.ToLower().Contains(email.ToLower()));
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

        public AccountSpec ByCreatedDateRange(DateTimeRange range)
        {
            AddPredicate(a => a.ChangedDate >= range.From && a.ChangedDate <= range.To);
            return this;
        }

        public AccountSpec WithDomain()
        {
            AddInclude(a => a.Domain);
            return this;
        }

        public AccountSpec WithCostAccount()
        {
            AddInclude(a => a.CostAccount);
            return this;
        }

        public AccountSpec WithPassport()
        {
            AddInclude(a => a.Passport);
            return this;
        }

        public AccountSpec WithAliases()
        {
            AddInclude(a => a.AccountAliases);
            return this;
        }

        public AccountSpec WithAllRelationships()
        {
            WithDomain();
            WithCostAccount();
            WithPassport();
            WithAliases();
            return this;
        }

        public AccountSpec OrderByLogonName(bool ascending = true)
        {
            if (ascending)
                ApplyOrderBy(q => q.OrderBy(a => a.LogonName));
            else
                ApplyOrderBy(q => q.OrderByDescending(a => a.LogonName));
            return this;
        }

        public AccountSpec OrderByChangedDate(bool ascending = true)
        {
            if (ascending)
                ApplyOrderBy(q => q.OrderBy(a => a.ChangedDate));
            else
                ApplyOrderBy(q => q.OrderByDescending(a => a.ChangedDate));
            return this;
        }

        public AccountSpec Take(int count)
        {
            ApplyPaging(0, count);
            return this;
        }

        public AccountSpec Skip(int count)
        {
            ApplyPaging(count, 0);
            return this;
        }

        public AccountSpec Page(int pageNumber, int pageSize)
        {
            ApplyPaging((pageNumber - 1) * pageSize, pageSize);
            return this;
        }
    }
}
```

### Printer Device Specification

```csharp
// Domain/Specifications/PrinterDeviceSpec.cs
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Portal360.Domain.Entities;
using Portal360.Domain.Filters;

namespace Portal360.Domain.Specifications
{
    public class PrinterDeviceSpec : Specification<PrinterDevice>
    {
        public PrinterDeviceSpec ByFilter(PrinterDeviceFilter filter)
        {
            if (filter.PrinterDeviceId != 0)
                ByPrinterDeviceId(filter.PrinterDeviceId);

            if (filter.MachineId.HasValue)
                ByMachineId(filter.MachineId.Value);

            if (filter.CostAccountId.HasValue)
                ByCostAccountId(filter.CostAccountId.Value);

            if (!string.IsNullOrEmpty(filter.PrinterQueueName))
                ByQueueName(filter.PrinterQueueName);

            if (filter.PrinterModelId.HasValue)
                ByPrinterModelId(filter.PrinterModelId.Value);

            if (filter.IsActive.HasValue)
                ByIsActive(filter.IsActive.Value);

            if (filter.IsConsolidated.HasValue)
                ByIsConsolidated(filter.IsConsolidated.Value);

            return this;
        }

        public PrinterDeviceSpec ByPrinterDeviceId(long printerDeviceId)
        {
            AddPredicate(pd => pd.PrinterDeviceID == printerDeviceId);
            return this;
        }

        public PrinterDeviceSpec ByMachineId(long machineId)
        {
            AddPredicate(pd => pd.MachineID == machineId);
            return this;
        }

        public PrinterDeviceSpec ByCostAccountId(int costAccountId)
        {
            AddPredicate(pd => pd.CostAccountID == costAccountId);
            return this;
        }

        public PrinterDeviceSpec ByQueueName(string queueName)
        {
            AddPredicate(pd => pd.PrinterQueueName.ToLower().Contains(queueName.ToLower()));
            return this;
        }

        public PrinterDeviceSpec ByPrinterModelId(int printerModelId)
        {
            AddPredicate(pd => pd.PrinterModelID == printerModelId);
            return this;
        }

        public PrinterDeviceSpec ByIsActive(bool isActive)
        {
            AddPredicate(pd => pd.IsActive == isActive);
            return this;
        }

        public PrinterDeviceSpec ByIsConsolidated(bool isConsolidated)
        {
            if (isConsolidated)
                AddPredicate(pd => pd.PrinterDeviceID != pd.RealPrinterDeviceID);
            else
                AddPredicate(pd => pd.PrinterDeviceID == pd.RealPrinterDeviceID);
            return this;
        }

        public PrinterDeviceSpec WithMachine()
        {
            AddInclude(pd => pd.Machine);
            return this;
        }

        public PrinterDeviceSpec WithPrinterModel()
        {
            AddInclude(query => query
                .Include(pd => pd.PrinterModel)
                .ThenInclude(pm => pm.PrinterBrand));
            return this;
        }

        public PrinterDeviceSpec WithCostAccount()
        {
            AddInclude(pd => pd.CostAccount);
            return this;
        }

        public PrinterDeviceSpec WithRealPrinter()
        {
            AddInclude(pd => pd.RealPrinterDevice);
            return this;
        }

        public PrinterDeviceSpec WithAllRelationships()
        {
            WithMachine();
            WithPrinterModel();
            WithCostAccount();
            WithRealPrinter();
            return this;
        }

        public PrinterDeviceSpec OrderByQueueName(bool ascending = true)
        {
            if (ascending)
                ApplyOrderBy(q => q.OrderBy(pd => pd.PrinterQueueName));
            else
                ApplyOrderBy(q => q.OrderByDescending(pd => pd.PrinterQueueName));
            return this;
        }
    }
}
```

---

## Bulk Operations Repository

### Interface

```csharp
// Domain/Contracts/Repositories/IBulkOperationRepository.cs
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Portal360.Domain.Contracts.Repositories
{
    public interface IBulkOperationRepository
    {
        // Account bulk operations
        Task<int> BulkDisableAccountsAsync(List<int> accountIds);
        Task<int> BulkEnableAccountsAsync(List<int> accountIds);
        Task<int> BulkUpdateAccountCostAccountAsync(List<int> accountIds, int newCostAccountId);
        Task<int> BulkRemoveAccountsAsync(List<int> accountIds);
        Task<int> BulkDeleteRemovedAccountsAsync(DateTime beforeDate);

        // Printer bulk operations
        Task<int> BulkDisablePrintersAsync(List<long> printerIds);
        Task<int> BulkEnablePrintersAsync(List<long> printerIds);
        Task<int> BulkUpdatePrinterCostAccountAsync(List<long> printerIds, int newCostAccountId);

        // Policy bulk operations
        Task<int> BulkApplyPolicyToAccountsAsync(int policyId, List<int> accountIds);
        Task<int> BulkRemovePolicyFromAccountsAsync(int policyId, List<int> accountIds);

        // Print job bulk operations
        Task<int> BulkDeleteOldPrintJobsAsync(DateTime beforeDate);
    }
}
```

### Implementation

```csharp
// Data/Repositories/BulkOperationRepository.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Portal360.Domain.Contracts.Repositories;
using Portal360.Domain.Entities;

namespace Portal360.Data.Repositories
{
    public class BulkOperationRepository : IBulkOperationRepository
    {
        private readonly Portal360DbContext _context;

        public BulkOperationRepository(Portal360DbContext context)
        {
            _context = context;
        }

        #region Account Bulk Operations

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
        public async Task<int> BulkUpdateAccountCostAccountAsync(
            List<int> accountIds, 
            int newCostAccountId)
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

        // proc_360_Accounts_BulkDeleteRemoved
        public async Task<int> BulkDeleteRemovedAccountsAsync(DateTime beforeDate)
        {
            return await _context.Accounts
                .Where(a => a.Removed && a.ChangedDate < beforeDate)
                .ExecuteDeleteAsync();
        }

        #endregion

        #region Printer Bulk Operations

        // proc_360_PrintersDevices_BulkDisable
        public async Task<int> BulkDisablePrintersAsync(List<long> printerIds)
        {
            return await _context.PrintersDevices
                .Where(pd => printerIds.Contains(pd.PrinterDeviceID))
                .ExecuteUpdateAsync(s => s
                    .SetProperty(pd => pd.IsActive, false)
                    .SetProperty(pd => pd.ChangedDate, DateTime.UtcNow));
        }

        // proc_360_PrintersDevices_BulkEnable
        public async Task<int> BulkEnablePrintersAsync(List<long> printerIds)
        {
            return await _context.PrintersDevices
                .Where(pd => printerIds.Contains(pd.PrinterDeviceID))
                .ExecuteUpdateAsync(s => s
                    .SetProperty(pd => pd.IsActive, true)
                    .SetProperty(pd => pd.ChangedDate, DateTime.UtcNow));
        }

        // proc_360_PrintersDevices_BulkUpdateCostAccount
        public async Task<int> BulkUpdatePrinterCostAccountAsync(
            List<long> printerIds, 
            int newCostAccountId)
        {
            return await _context.PrintersDevices
                .Where(pd => printerIds.Contains(pd.PrinterDeviceID))
                .ExecuteUpdateAsync(s => s
                    .SetProperty(pd => pd.CostAccountID, newCostAccountId)
                    .SetProperty(pd => pd.ChangedDate, DateTime.UtcNow));
        }

        #endregion

        #region Policy Bulk Operations

        // proc_360_Policies_BulkApplyToAccounts
        public async Task<int> BulkApplyPolicyToAccountsAsync(int policyId, List<int> accountIds)
        {
            var policyControls = accountIds.Select(id => new PolicyControlAccount
            {
                PolicyID = policyId,
                AccountID = id,
                CreatedDate = DateTime.UtcNow,
                IsActive = true
            }).ToList();

            _context.PoliciesControlsAccounts.AddRange(policyControls);
            return await _context.SaveChangesAsync();
        }

        // proc_360_Policies_BulkRemoveFromAccounts
        public async Task<int> BulkRemovePolicyFromAccountsAsync(int policyId, List<int> accountIds)
        {
            return await _context.PoliciesControlsAccounts
                .Where(pca => pca.PolicyID == policyId && accountIds.Contains(pca.AccountID))
                .ExecuteDeleteAsync();
        }

        #endregion

        #region Print Job Bulk Operations

        // proc_360_PrintJobs_BulkDeleteOld
        public async Task<int> BulkDeleteOldPrintJobsAsync(DateTime beforeDate)
        {
            return await _context.PrintJobs
                .Where(pj => pj.DatePrinted < beforeDate)
                .ExecuteDeleteAsync();
        }

        #endregion
    }
}
```

---

This continues in the next part...
