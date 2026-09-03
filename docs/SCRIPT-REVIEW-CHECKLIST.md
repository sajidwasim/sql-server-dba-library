# Script Review Checklist

- Identity: stable ID, title, owner, provenance, license
- Intent: purpose, scope, expected result, failure behavior
- Safety: read/change/destructive classification, transactions, rollback, cleanup
- Target: SQL Server versions, Azure variants, OS and feature dependencies
- Access: minimum permissions and credential model
- Quality: syntax, parameters, hardcoded values, error handling, idempotency
- Performance: reads, CPU, duration, blocking, tempdb, log and storage impact
- Evidence: isolated test run, before/after state, result contract, reviewer
