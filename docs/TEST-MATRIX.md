# Test Matrix

| Lane | Target | Purpose |
|---|---|---|
| Static | No database | Metadata, secrets, forbidden operations, encoding and naming |
| SQL 2019 | Disposable container | Compatibility and integration behavior |
| SQL 2022 | Disposable container | Current boxed SQL Server behavior |
| Windows SQL Server | Isolated VM | SQL Agent, AD, registry, Windows paths and Windows-only features |
| Azure SQL Database | Isolated resource | Platform-specific syntax, permissions and DMVs |
| Managed Instance | Isolated resource when required | Instance-like Azure behavior |
| Destructive | Dedicated disposable instance | Restore, drop, failover, TDE, filesystem and server-level changes |

Passing one lane does not imply compatibility with another.
