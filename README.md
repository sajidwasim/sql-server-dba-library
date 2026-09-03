# SQL Server DBA Script Library

This repository is a curated SQL Server administration library. Scripts are separated by trust level so that discovery does not imply production approval.

Start with [00-Start-Here/README.md](00-Start-Here/README.md), then review [AGENTS.md](AGENTS.md) and [SECURITY.md](SECURITY.md) before running or changing any script.

## Trust levels

| Location | Meaning |
|---|---|
| `10-Runbooks` | Human-readable operational procedures |
| `20-Production-Candidates` | Candidates that still require environment-specific review |
| `30-Lab-and-Learning` | Examples and experiments, not production-approved |
| `40-Controlled-Change-Scripts` | Scripts requiring an approved change window and rollback plan |
| `90-Third-Party-and-Legacy` | External or historical material with limited trust |
| `99-Quarantine` | Unsafe, incomplete, unknown, or security-sensitive content. Never execute directly |

## Required validation

```powershell
pwsh -NoProfile -File ./tools/Test-SqlScriptPolicy.ps1
```

No script becomes production-ready solely because it exists in this repository. Promotion requires review, testing, evidence, rollback instructions, and an accountable owner.
