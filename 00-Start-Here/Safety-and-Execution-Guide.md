# Safety and Execution Guide

Risk labels are routing aids, not guarantees.

| Location | Default rule |
|---|---|
| Production Candidates | Read-only intent, but validate permissions and workload impact |
| Controlled Change Scripts | Require testing, approval, validation, and rollback |
| Runbooks | Follow documented order and stop at decision points |
| Lab and Learning | Never execute blindly against production |
| Third Party and Legacy | Verify source, license, version, and dependencies |
| Quarantine | Do not execute until the stated problem is resolved |

Treat `KILL`, `DROP`, `TRUNCATE`, forced offline operations, cache clearing, `xp_cmdshell`, file deletion, TDE changes, replication teardown, failover, restore, and credential creation as high-risk operations.

Credential-bearing files found during curation were isolated. Any credential that was ever valid must be rotated outside this library. Moving or redacting a file does not revoke a credential.
