# Script Promotion Policy

Promotion is a trust decision supported by evidence. A folder name is not proof of safety.

| Gate | Minimum requirement |
|---|---|
| Identity | Unique script name, purpose, owner, category, and source |
| Safety | No embedded credentials; scope checks; guarded destructive operations |
| Compatibility | Supported SQL Server versions and platform assumptions documented |
| Correctness | Expected output and failure behavior verified on disposable databases |
| Operations | Permissions, duration, locking, resource impact, and observability documented |
| Recovery | Rollback or recovery procedure tested where changes occur |
| Review | Independent DBA approval recorded for production candidates |

Scripts with unknown provenance, unclear intent, credential material, or unbounded destructive behavior remain in `99-Quarantine`.

Graph analysis, linting, and AI review can identify risk. None of them can independently approve a script for production.
