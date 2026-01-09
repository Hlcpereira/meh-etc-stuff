# Portal 360 Repository Implementation Guide - Part 2
## Hierarchy Services & Complete Examples

---

## Hierarchy Services (Using HierarchyId - EF Core 8+)

### Interface

```csharp
// Domain/Contracts/Services/ICostAccountHierarchyService.cs
using System.Collections.Generic;
using System.Threading.Tasks;
using Portal360.Domain.Entities;

namespace Portal360.Domain.Contracts.Services
{
    public interface ICostAccountHierarchyService
    {
        // fn_360_GetAllPrintersFromCostAccounts
        Task<List<int>> GetAllPrinterIdsAsync(int costAccountId);
        
        // fn_360_GetCostAccountManaged
        Task<List<int>> GetManagedCostAccountsAsync(int managerId);
        
        // proc_360_CostAccounts_GetHierarchy
        Task<List<CostAccount>> GetHierarchyAsync(int rootId);
        
        // proc_360_CostAccounts_GetChildren
        Task<List<CostAccount>> GetChildrenAsync(int parentId);
        
        // proc_360_CostAccounts_GetAncestors
        Task<List<CostAccount>> GetAncestorsAsync(int nodeId);
        
        // proc_360_CostAccounts_Move
        Task MoveNodeAsync(int nodeId, int? newParentId);
        
        // Utility methods
        Task<int> GetLevelAsync(int nodeId);
        Task<string> GetFullPathAsync(int nodeId);
    }
}
```

### Implementation

```csharp
// Application/Services/CostAccountHierarchyService.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Portal360.Data;
using Portal360.Domain.Contracts.Services;
using Portal360.Domain.Entities;

namespace Portal360.Application.Services
{
    public class CostAccountHierarchyService : ICostAccountHierarchyService
    {
        private readonly Portal360DbContext _context;

        public CostAccountHierarchyService(Portal360DbContext context)
        {
            _context = context;
        }

        // fn_360_GetAllPrintersFromCostAccounts
        public async Task<List<int>> GetAllPrinterIdsAsync(int costAccountId)
        {
            var root = await _context.CostAccounts
                .Where(ca => ca.CostAccountID == costAccountId)
                .Select(ca => ca.HierarchyPath)
                .FirstOrDefaultAsync();

            if (root == null)
                return new List<int>();

            // Get all cost accounts in hierarchy
            var costAccountIds = await _context.CostAccounts
                .Where(ca => ca.HierarchyPath.IsDescendantOf(root))
                .Select(ca => ca.CostAccountID)
                .ToListAsync();

            // Get all printers from those cost accounts
            return await _context.PrintersDevices
                .Where(pd => pd.CostAccountID.HasValue && 
                            costAccountIds.Contains(pd.CostAccountID.Value))
                .Select(pd => pd.PrinterDeviceID)
                .Distinct()
                .ToListAsync();
        }

        // fn_360_GetCostAccountManaged
        public async Task<List<int>> GetManagedCostAccountsAsync(int managerId)
        {
            // Get root accounts managed by user
            var rootPaths = await _context.CostAccountsManagers
                .Where(cam => cam.AccountID == managerId)
                .Select(cam => cam.CostAccount.HierarchyPath)
                .ToListAsync();

            if (!rootPaths.Any())
                return new List<int>();

            // Get all descendants of managed accounts
            return await _context.CostAccounts
                .Where(ca => rootPaths.Any(root => ca.HierarchyPath.IsDescendantOf(root)))
                .Select(ca => ca.CostAccountID)
                .ToListAsync();
        }

        // proc_360_CostAccounts_GetHierarchy
        public async Task<List<CostAccount>> GetHierarchyAsync(int rootId)
        {
            var root = await _context.CostAccounts.FindAsync(rootId);
            if (root == null)
                return new List<CostAccount>();

            // Fast server-side query using HierarchyId
            return await _context.CostAccounts
                .Where(ca => ca.HierarchyPath.IsDescendantOf(root.HierarchyPath))
                .OrderBy(ca => ca.HierarchyPath)
                .ToListAsync();
        }

        // proc_360_CostAccounts_GetChildren
        public async Task<List<CostAccount>> GetChildrenAsync(int parentId)
        {
            var parent = await _context.CostAccounts.FindAsync(parentId);
            if (parent == null)
                return new List<CostAccount>();

            // Get only direct children (one level down)
            return await _context.CostAccounts
                .Where(ca => ca.HierarchyPath.GetLevel() == parent.HierarchyPath.GetLevel() + 1 &&
                            ca.HierarchyPath.IsDescendantOf(parent.HierarchyPath))
                .OrderBy(ca => ca.CostAccountName)
                .ToListAsync();
        }

        // proc_360_CostAccounts_GetAncestors
        public async Task<List<CostAccount>> GetAncestorsAsync(int nodeId)
        {
            var node = await _context.CostAccounts.FindAsync(nodeId);
            if (node == null)
                return new List<CostAccount>();

            // Get all ancestors (excluding the node itself)
            return await _context.CostAccounts
                .Where(ca => node.HierarchyPath.IsDescendantOf(ca.HierarchyPath) && 
                            ca.CostAccountID != nodeId)
                .OrderBy(ca => ca.HierarchyPath)
                .ToListAsync();
        }

        // proc_360_CostAccounts_Move
        public async Task MoveNodeAsync(int nodeId, int? newParentId)
        {
            var node = await _context.CostAccounts.FindAsync(nodeId);
            if (node == null)
                throw new InvalidOperationException($"Cost account {nodeId} not found");

            var oldPath = node.HierarchyPath;
            HierarchyId newPath;

            if (newParentId == null)
            {
                // Move to root
                newPath = HierarchyId.Parse($"/{nodeId}/");
            }
            else
            {
                var newParent = await _context.CostAccounts.FindAsync(newParentId.Value);
                if (newParent == null)
                    throw new InvalidOperationException($"Parent cost account {newParentId} not found");

                // Calculate new path
                newPath = HierarchyId.Parse($"{newParent.HierarchyPath}{nodeId}/");
            }

            // Update node
            node.CostAccountParentID = newParentId;
            node.HierarchyPath = newPath;

            // Update all descendants
            var descendants = await _context.CostAccounts
                .Where(ca => ca.HierarchyPath.IsDescendantOf(oldPath) && 
                            ca.CostAccountID != nodeId)
                .ToListAsync();

            foreach (var descendant in descendants)
            {
                var relativePath = descendant.HierarchyPath.ToString()
                    .Replace(oldPath.ToString(), "");
                descendant.HierarchyPath = HierarchyId.Parse(newPath.ToString() + relativePath);
            }

            await _context.SaveChangesAsync();
        }

        // Get level in hierarchy
        public async Task<int> GetLevelAsync(int nodeId)
        {
            var node = await _context.CostAccounts
                .Where(ca => ca.CostAccountID == nodeId)
                .Select(ca => ca.HierarchyPath)
                .FirstOrDefaultAsync();

            return node?.GetLevel() ?? 0;
        }

        // Get full path as string
        public async Task<string> GetFullPathAsync(int nodeId)
        {
            var node = await _context.CostAccounts.FindAsync(nodeId);
            if (node == null)
                return string.Empty;

            var ancestors = await _context.CostAccounts
                .Where(ca => node.HierarchyPath.IsDescendantOf(ca.HierarchyPath) &&
                            ca.CostAccountID != nodeId)
                .OrderBy(ca => ca.HierarchyPath)
                .Select(ca => ca.CostAccountName)
                .ToListAsync();

            ancestors.Add(node.CostAccountName);
            return string.Join(" > ", ancestors);
        }
    }
}
```

---

## Complete Examples - Usage in Controllers/Services

### Example 1: Account Controller

```csharp
// API/Controllers/AccountsController.cs
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Portal360.Domain.Contracts.Repositories;
using Portal360.Domain.Filters;
using Portal360.Domain.Entities;

namespace Portal360.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AccountsController : ControllerBase
    {
        private readonly IAccountRepository _accountRepository;
        private readonly IBulkOperationRepository _bulkOperationRepository;

        public AccountsController(
            IAccountRepository accountRepository,
            IBulkOperationRepository bulkOperationRepository)
        {
            _accountRepository = accountRepository;
            _bulkOperationRepository = bulkOperationRepository;
        }

        // GET: api/accounts/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<Account>> GetById(int id)
        {
            var account = await _accountRepository.GetByIdAsync(id);
            
            if (account == null)
                return NotFound();

            return Ok(account);
        }

        // GET: api/accounts/guid/{guid}
        [HttpGet("guid/{guid}")]
        public async Task<ActionResult<Account>> GetByGuid(Guid guid)
        {
            var account = await _accountRepository.GetByGuidAsync(guid);
            
            if (account == null)
                return NotFound();

            return Ok(account);
        }

        // GET: api/accounts/domain/{domainId}
        [HttpGet("domain/{domainId}")]
        public async Task<ActionResult<List<Account>>> GetByDomain(int domainId)
        {
            var accounts = await _accountRepository.GetByDomainAsync(domainId);
            return Ok(accounts);
        }

        // GET: api/accounts/search?term=john
        [HttpGet("search")]
        public async Task<ActionResult<List<Account>>> Search([FromQuery] string term)
        {
            if (string.IsNullOrWhiteSpace(term))
                return BadRequest("Search term is required");

            var accounts = await _accountRepository.SearchByNameAsync(term);
            return Ok(accounts);
        }

        // POST: api/accounts/filter
        [HttpPost("filter")]
        public async Task<ActionResult<List<Account>>> GetByFilter([FromBody] AccountFilter filter)
        {
            var accounts = await _accountRepository.GetByFilterAsync(filter);
            return Ok(accounts);
        }

        // GET: api/accounts/active
        [HttpGet("active")]
        public async Task<ActionResult<List<Account>>> GetActive()
        {
            var accounts = await _accountRepository.GetActiveAccountsAsync();
            return Ok(accounts);
        }

        // POST: api/accounts
        [HttpPost]
        public async Task<ActionResult<Account>> Create([FromBody] Account account)
        {
            await _accountRepository.AddAsync(account);
            await _accountRepository.Context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new { id = account.AccountID }, account);
        }

        // PUT: api/accounts/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] Account account)
        {
            if (id != account.AccountID)
                return BadRequest();

            _accountRepository.Modify(account);
            await _accountRepository.Context.SaveChangesAsync();

            return NoContent();
        }

        // DELETE: api/accounts/{id} (soft delete)
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            await _accountRepository.SoftDeleteAsync(id);
            return NoContent();
        }

        // POST: api/accounts/bulk/disable
        [HttpPost("bulk/disable")]
        public async Task<ActionResult<int>> BulkDisable([FromBody] List<int> accountIds)
        {
            var count = await _bulkOperationRepository.BulkDisableAccountsAsync(accountIds);
            return Ok(new { DisabledCount = count });
        }

        // POST: api/accounts/bulk/enable
        [HttpPost("bulk/enable")]
        public async Task<ActionResult<int>> BulkEnable([FromBody] List<int> accountIds)
        {
            var count = await _bulkOperationRepository.BulkEnableAccountsAsync(accountIds);
            return Ok(new { EnabledCount = count });
        }
    }
}
```

### Example 2: Using Specification Pattern in Service Layer

```csharp
// Application/Services/AccountService.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Portal360.Data;
using Portal360.Domain.Contracts.Repositories;
using Portal360.Domain.Contracts.Services;
using Portal360.Domain.Entities;
using Portal360.Domain.Specifications;

namespace Portal360.Application.Services
{
    public class AccountService : IAccountService
    {
        private readonly Portal360DbContext _context;
        private readonly IAccountRepository _accountRepository;

        public AccountService(
            Portal360DbContext context,
            IAccountRepository accountRepository)
        {
            _context = context;
            _accountRepository = accountRepository;
        }

        public async Task<List<Account>> GetActiveAccountsInDomainAsync(int domainId)
        {
            var spec = new AccountSpec()
                .ByDomainId(domainId)
                .ByIsActive(true)
                .ExcludeRemoved()
                .WithDomain()
                .OrderByLogonName();

            var query = _context.Accounts.AsQueryable();
            query = spec.Apply(query);

            return await query.AsNoTracking().ToListAsync();
        }

        public async Task<List<Account>> SearchAccountsAsync(string searchTerm, int? domainId = null)
        {
            var spec = new AccountSpec()
                .ByLogonName(searchTerm)
                .ExcludeRemoved()
                .WithDomain()
                .WithCostAccount()
                .OrderByLogonName()
                .Take(50);

            if (domainId.HasValue)
                spec.ByDomainId(domainId.Value);

            var query = _context.Accounts.AsQueryable();
            query = spec.Apply(query);

            return await query.AsNoTracking().ToListAsync();
        }

        public async Task<PagedResult<Account>> GetAccountsPagedAsync(
            int domainId,
            int pageNumber,
            int pageSize)
        {
            var spec = new AccountSpec()
                .ByDomainId(domainId)
                .ExcludeRemoved()
                .WithDomain()
                .WithCostAccount()
                .OrderByLogonName()
                .Page(pageNumber, pageSize);

            // Get total count first
            var totalCount = await _context.Accounts
                .Where(a => a.DomainID == domainId && !a.Removed)
                .CountAsync();

            // Get paged data
            var query = _context.Accounts.AsQueryable();
            query = spec.Apply(query);
            var accounts = await query.AsNoTracking().ToListAsync();

            return new PagedResult<Account>
            {
                Items = accounts,
                TotalCount = totalCount,
                PageNumber = pageNumber,
                PageSize = pageSize
            };
        }
    }

    public class PagedResult<T>
    {
        public List<T> Items { get; set; }
        public int TotalCount { get; set; }
        public int PageNumber { get; set; }
        public int PageSize { get; set; }
        public int TotalPages => (int)Math.Ceiling(TotalCount / (double)PageSize);
    }
}
```

### Example 3: Complex Filter Usage

```csharp
// Domain/Filters/AccountFilter.cs
using System;
using Portal360.Domain.ValueObjects;

namespace Portal360.Domain.Filters
{
    public class AccountFilter
    {
        public int AccountId { get; set; }
        public Guid AccountGuid { get; set; }
        public string LogonName { get; set; }
        public string Email { get; set; }
        public int DomainId { get; set; }
        public int? CostAccountId { get; set; }
        public bool? IsActive { get; set; }
        public bool IncludeRemoved { get; set; }
        public DateTimeRange CreatedDateRange { get; set; }
        
        // Pagination
        public int? PageNumber { get; set; }
        public int? PageSize { get; set; }
        public string SortField { get; set; }
        public string SortOrder { get; set; }
        
        // Include options
        public bool IncludeDomain { get; set; }
        public bool IncludeCostAccount { get; set; }
        public bool IncludePassport { get; set; }
        public bool IncludeAliases { get; set; }
    }
}

// Usage in Repository
public async Task<List<Account>> GetByFilterAsync(AccountFilter filter)
{
    var spec = new AccountSpec()
        .ByFilter(filter);

    // Add includes based on filter
    if (filter.IncludeDomain)
        spec.WithDomain();
    
    if (filter.IncludeCostAccount)
        spec.WithCostAccount();
    
    if (filter.IncludePassport)
        spec.WithPassport();
    
    if (filter.IncludeAliases)
        spec.WithAliases();

    // Add pagination
    if (filter.PageNumber.HasValue && filter.PageSize.HasValue)
        spec.Page(filter.PageNumber.Value, filter.PageSize.Value);

    var query = _context.Accounts.AsQueryable();
    query = spec.Apply(query);

    return await query.AsNoTracking().ToListAsync();
}
```

---

## Dependency Injection Setup

```csharp
// Program.cs or Startup.cs
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Portal360.Data;
using Portal360.Data.Repositories;
using Portal360.Domain.Contracts.Repositories;
using Portal360.Domain.Contracts.Services;
using Portal360.Application.Services;

var builder = WebApplication.CreateBuilder(args);

// Add DbContext
builder.Services.AddDbContext<Portal360DbContext>(options =>
{
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("Portal360"),
        sqlOptions =>
        {
            sqlOptions.EnableRetryOnFailure(
                maxRetryCount: 3,
                maxRetryDelay: TimeSpan.FromSeconds(5),
                errorNumbersToAdd: null);
            
            sqlOptions.CommandTimeout(30);
            
            // Enable HierarchyId support
            sqlOptions.UseHierarchyId();
        });
});

// Register Repositories
builder.Services.AddScoped(typeof(IRepository<>), typeof(Repository<>));
builder.Services.AddScoped<IAccountRepository, AccountRepository>();
builder.Services.AddScoped<IPrinterDeviceRepository, PrinterDeviceRepository>();
builder.Services.AddScoped<IBulkOperationRepository, BulkOperationRepository>();
// ... register all other repositories

// Register Services
builder.Services.AddScoped<IAccountService, AccountService>();
builder.Services.AddScoped<ICostAccountHierarchyService, CostAccountHierarchyService>();
// ... register all other services

var app = builder.Build();

app.Run();
```

---

## Testing Examples

### Unit Test Example

```csharp
// Tests/Repositories/AccountRepositoryTests.cs
using System;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Portal360.Data;
using Portal360.Data.Repositories;
using Portal360.Domain.Entities;
using Xunit;

namespace Portal360.Tests.Repositories
{
    public class AccountRepositoryTests : IDisposable
    {
        private readonly Portal360DbContext _context;
        private readonly AccountRepository _repository;

        public AccountRepositoryTests()
        {
            var options = new DbContextOptionsBuilder<Portal360DbContext>()
                .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
                .Options;

            _context = new Portal360DbContext(options);
            _repository = new AccountRepository(_context);

            SeedTestData();
        }

        private void SeedTestData()
        {
            var domain = new Domain
            {
                DomainID = 1,
                DomainName = "TestDomain",
                DomainTypeID = 4,
                IsActive = true
            };

            var account = new Account
            {
                AccountID = 1,
                DomainID = 1,
                LogonName = "testuser",
                FullName = "Test User",
                Email = "test@example.com",
                IsActive = true,
                Removed = false,
                ChangedDate = DateTime.UtcNow,
                AccountGuidId = Guid.NewGuid()
            };

            _context.Domains.Add(domain);
            _context.Accounts.Add(account);
            _context.SaveChanges();
        }

        [Fact]
        public async Task GetByIdAsync_ShouldReturnAccount_WhenExists()
        {
            // Act
            var result = await _repository.GetByIdAsync(1);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("testuser", result.LogonName);
            Assert.Equal("Test User", result.FullName);
        }

        [Fact]
        public async Task GetByIdAsync_ShouldReturnNull_WhenNotExists()
        {
            // Act
            var result = await _repository.GetByIdAsync(999);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task GetByDomainAsync_ShouldReturnAccounts_InDomain()
        {
            // Act
            var results = await _repository.GetByDomainAsync(1);

            // Assert
            Assert.Single(results);
            Assert.Equal("testuser", results[0].LogonName);
        }

        [Fact]
        public async Task SearchByNameAsync_ShouldReturnMatches()
        {
            // Act
            var results = await _repository.SearchByNameAsync("test");

            // Assert
            Assert.Single(results);
            Assert.Contains("test", results[0].LogonName.ToLower());
        }

        [Fact]
        public async Task SoftDeleteAsync_ShouldMarkAsRemoved()
        {
            // Act
            await _repository.SoftDeleteAsync(1);
            await _context.SaveChangesAsync();

            // Reload from DB
            var account = await _context.Accounts.FindAsync(1);

            // Assert
            Assert.True(account.Removed);
        }

        public void Dispose()
        {
            _context?.Dispose();
        }
    }
}
```

### Integration Test Example

```csharp
// Tests/Integration/AccountRepositoryIntegrationTests.cs
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Portal360.Data;
using Portal360.Data.Repositories;
using Portal360.Domain.Entities;
using Xunit;

namespace Portal360.Tests.Integration
{
    public class AccountRepositoryIntegrationTests : IDisposable
    {
        private readonly Portal360DbContext _context;
        private readonly AccountRepository _repository;

        public AccountRepositoryIntegrationTests()
        {
            var configuration = new ConfigurationBuilder()
                .AddJsonFile("appsettings.Test.json")
                .Build();

            var options = new DbContextOptionsBuilder<Portal360DbContext>()
                .UseSqlServer(
                    configuration.GetConnectionString("TestDatabase"),
                    sqlOptions => sqlOptions.UseHierarchyId())
                .Options;

            _context = new Portal360DbContext(options);
            _repository = new AccountRepository(_context);

            // Ensure clean state
            _context.Database.EnsureCreated();
        }

        [Fact]
        public async Task GetByIdAsync_ShouldIncludeRelationships()
        {
            // Arrange
            var accountId = await CreateTestAccountAsync();

            // Act
            var account = await _repository.GetByIdAsync(accountId);

            // Assert
            Assert.NotNull(account);
            Assert.NotNull(account.Domain); // Should be loaded
            Assert.NotNull(account.CostAccount); // Should be loaded if exists
        }

        [Fact]
        public async Task GetByDomainAsync_ShouldReturnOrderedResults()
        {
            // Arrange
            var domainId = await CreateTestDomainAsync();
            await CreateMultipleAccountsAsync(domainId, 5);

            // Act
            var accounts = await _repository.GetByDomainAsync(domainId);

            // Assert
            Assert.Equal(5, accounts.Count);
            Assert.True(accounts.SequenceEqual(accounts.OrderBy(a => a.LogonName)));
        }

        private async Task<int> CreateTestAccountAsync()
        {
            var domain = new Domain
            {
                DomainName = $"TestDomain_{Guid.NewGuid()}",
                DomainTypeID = 4,
                IsActive = true
            };

            _context.Domains.Add(domain);
            await _context.SaveChangesAsync();

            var account = new Account
            {
                DomainID = domain.DomainID,
                LogonName = $"testuser_{Guid.NewGuid()}",
                IsActive = true,
                Removed = false,
                ChangedDate = DateTime.UtcNow,
                AccountGuidId = Guid.NewGuid()
            };

            _context.Accounts.Add(account);
            await _context.SaveChangesAsync();

            return account.AccountID;
        }

        private async Task<int> CreateTestDomainAsync()
        {
            var domain = new Domain
            {
                DomainName = $"TestDomain_{Guid.NewGuid()}",
                DomainTypeID = 4,
                IsActive = true
            };

            _context.Domains.Add(domain);
            await _context.SaveChangesAsync();

            return domain.DomainID;
        }

        private async Task CreateMultipleAccountsAsync(int domainId, int count)
        {
            for (int i = 0; i < count; i++)
            {
                var account = new Account
                {
                    DomainID = domainId,
                    LogonName = $"user{i:D3}",
                    IsActive = true,
                    Removed = false,
                    ChangedDate = DateTime.UtcNow,
                    AccountGuidId = Guid.NewGuid()
                };

                _context.Accounts.Add(account);
            }

            await _context.SaveChangesAsync();
        }

        public void Dispose()
        {
            _context?.Database.EnsureDeleted();
            _context?.Dispose();
        }
    }
}
```

---

## Summary & Best Practices

### Repository Pattern Benefits

✅ **Separation of Concerns**
- Data access logic isolated from business logic
- Easy to test (mock repositories)
- Clean architecture

✅ **Reusability**
- Common query patterns in base repository
- Specific queries in specific repositories
- Specification pattern for complex queries

✅ **Maintainability**
- Single source of truth for queries
- Easy to find and update data access code
- Clear naming conventions

✅ **Performance**
- AsNoTracking for read operations
- Efficient includes
- Bulk operations with ExecuteUpdate/ExecuteDelete

### Best Practices

1. **Use AsNoTracking for Read Operations**
```csharp
return await _context.Accounts
    .AsNoTracking()
    .ToListAsync();
```

2. **Use Specification Pattern for Complex Queries**
```csharp
var spec = new AccountSpec()
    .ByDomainId(domainId)
    .ExcludeRemoved()
    .WithDomain();
```

3. **Use Bulk Operations for Mass Updates**
```csharp
await _context.Accounts
    .Where(a => ids.Contains(a.AccountID))
    .ExecuteUpdateAsync(s => s.SetProperty(a => a.IsActive, false));
```

4. **Use HierarchyId for Hierarchical Data**
```csharp
return await _context.CostAccounts
    .Where(ca => ca.HierarchyPath.IsDescendantOf(root.HierarchyPath))
    .ToListAsync();
```

5. **Consistent Naming**
- GetByIdAsync - Single entity by ID
- GetByXAsync - Collection by criteria
- SearchAsync - Search operations
- Create/Update/Delete - CRUD operations
- Bulk* - Bulk operations

---

## Conclusion

This repository pattern implementation provides:

✅ Clean separation of concerns
✅ Reusable query patterns
✅ Specification pattern for complex queries
✅ Modern EF Core features (ExecuteUpdate, HierarchyId, JSON)
✅ Testable code
✅ Excellent performance
✅ Professional structure

**Perfect for Portal 360's 400-450 converted stored procedures!**
