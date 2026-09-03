# SQL Server DBA Operations Library

Start with `SQL-Server-DBA-Script-Inventory.xlsx`. It records every file, its original location, final location, risk, duplicate status, and curation reason.

## Trust boundaries

- `10-Runbooks`: related scripts that form an operational workflow. Read the package notes and validate every step before use.
- `20-Production-Candidates`: primarily read-only scripts that are candidates for production use. They still require compatibility, permission, and workload-impact validation.
- `30-Lab-and-Learning`: samples, book exercises, demonstrations, and generic T-SQL techniques. Do not treat these as production procedures.
- `40-Controlled-Change-Scripts`: scripts that change SQL Server, databases, jobs, objects, files, or configuration. Use formal change control.
- `90-Third-Party-and-Legacy`: community tools, vendor material, legacy utilities, and intact deployment packages. Preserve authorship, licenses, versions, and package ordering.
- `99-Quarantine`: destructive, sensitive, duplicated, environment-specific, unclear, or untrusted artifacts. Do not execute files directly from this area.

## Minimum execution checklist

1. Read the entire script.
2. Confirm the target instance, database, and object names.
3. Search for hardcoded paths, servers, accounts, IP addresses, and credentials.
4. Confirm required permissions and supported SQL Server version.
5. Estimate locking, logging, CPU, memory, storage, and availability impact.
6. Prepare validation and rollback steps.
7. Test in an isolated non-production environment.
8. Use peer review and change control for any state-changing script.

No file is production-safe merely because of its folder name.
