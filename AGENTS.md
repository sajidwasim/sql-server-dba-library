# SQL Server DBA Library Agent Contract

## Purpose

This repository contains SQL Server DBA scripts, operational runbooks, validation tooling, and planning material for a future SQL monitoring SaaS.

## Non-negotiable safety rules

- Never execute a script without an explicitly approved target instance and database.
- Never use production as the first test environment.
- Never execute anything from `99-Quarantine`.
- Treat `KILL`, `DROP`, `TRUNCATE`, `RESTORE`, forced offline operations, cache clearing, `xp_cmdshell`, failover, TDE changes, replication teardown, and filesystem deletion as high risk.
- Never add plaintext credentials, tokens, connection strings, private keys, customer identifiers, internal endpoints, or public-IP allowlists.
- Default to read-only inspection. A request to review or classify is not authorization to execute.
- Before a state-changing test, document expected changes, validation, rollback, and cleanup.
- Preserve canonical third-party filenames, attribution, licenses, and package ordering.
- Do not label a script production-ready from filename analysis or one successful execution.

## Required evidence for script promotion

1. Complete metadata matching `metadata/script.schema.json`.
2. Static policy checks pass.
3. Supported SQL Server targets are declared.
4. Disposable-database integration tests pass.
5. Required permissions and expected workload impact are documented.
6. Idempotency or repeat-execution behavior is recorded.
7. Before and after state is captured for changes.
8. Rollback or cleanup is demonstrated when applicable.
9. A human reviewer approves promotion.

## Trust boundaries

- `20-Production-Candidates` contains candidates, not certified scripts.
- `40-Controlled-Change-Scripts` requires change control.
- `99-Quarantine` is blocked from all automated execution.
- Generated test results are evidence, not source code.

## Validation commands

Run `pwsh ./tools/Test-SqlScriptPolicy.ps1` before committing SQL or PowerShell changes.

Do not suppress a failed rule without documenting the reason and obtaining review.
