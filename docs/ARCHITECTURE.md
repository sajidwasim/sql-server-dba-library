# Repository Architecture

The repository is organized around operational trust, not only SQL Server subject areas.

1. A script enters through lab, legacy, or quarantine.
2. Static policy checks reject obvious credential and safety problems.
3. A DBA reviews purpose, scope, permissions, compatibility, locking, performance, and failure behavior.
4. The script is tested against supported SQL Server versions using disposable databases.
5. Evidence and rollback instructions are recorded.
6. Only then may the script move to `20-Production-Candidates` or `40-Controlled-Change-Scripts`.

The future SaaS monitoring product should remain a separate repository. This library can supply reviewed diagnostic queries, but it must not become coupled to tenant identity, billing, web application deployment, or customer credential storage.

## Intended automation layers

| Layer | Responsibility |
|---|---|
| Static policy | Detect credentials, unsafe defaults, and missing controls |
| Metadata | Describe ownership, compatibility, risk, and test state |
| Ephemeral SQL Server | Execute safe tests against disposable instances |
| Review evidence | Store deterministic results and reviewer decisions |
| Promotion gate | Prevent unverified content from being presented as production-ready |
| Knowledge graph | Improve navigation and impact analysis, never replace execution tests |
