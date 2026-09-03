# AI Bootstrap Instructions

Give the following instruction to a capable coding agent while its working directory is the repository root.

## Installation and configuration prompt

```text
You are setting up a private SQL Server DBA script-validation repository and a foundation for a future SQL monitoring SaaS.

Read AGENTS.md, SECURITY.md, CONTRIBUTING.md, docs/TEST-MATRIX.md, docs/SCRIPT-REVIEW-CHECKLIST.md, and metadata/script.schema.json before making changes.

Safety boundaries:
- Never execute anything in 99-Quarantine.
- Never connect to production or to an unapproved database.
- Do not expose, print, restore, or commit credentials.
- Use disposable SQL Server containers for initial integration testing.
- State-changing and destructive scripts require an explicit target, isolated environment, before/after evidence, validation, cleanup, and rollback.
- Preserve third-party names, licensing, provenance, and ordered deployment packages.

Set up the following in order:

1. Verify Git, GitHub CLI, Docker, PowerShell 7, .NET, sqlcmd, and SqlPackage. Report missing dependencies instead of silently installing system-wide software.
2. Confirm the repository is private before pushing any source.
3. Run pwsh ./tools/Test-SqlScriptPolicy.ps1. Stop before the first commit if it reports secrets or an unexplained unsafe operation outside quarantine.
4. Configure branch protection for main with pull requests, required reviews, required status checks, conversation resolution, and blocked force pushes.
5. Configure GitHub secret scanning and push protection where the account plan supports them.
6. Store test credentials in GitHub environments or use OIDC. Never place them in repository variables, files, command arguments, logs, or examples.
7. Install Graphify from its official Graphify-Labs/graphify repository in an isolated environment. Build the graph for bounded areas first: 10-Runbooks, 20-Production-Candidates, and the DBAdmin deployment package. Record false positives and missed relationships before adopting it in CI.
8. Do not install Mem0 yet. Add it only after a concrete tenant-scoped memory use case, deletion contract, retention policy, poisoning defense, and isolation tests exist.
9. Do not install code-review-graph for this script repository yet. Re-evaluate it when the SaaS repository contains multiple application packages, call graphs, tests, and pull-request impact-analysis needs.
10. Configure the Codex Security plugin for repository security review. Do not grant infrastructure write permissions unless a later task explicitly requires them.
11. Do not configure Cloudflare until the SaaS hosting architecture selects Cloudflare. Do not configure multiple project-management plugins. Choose one system of record.
12. Create or install a sql-server-script-certifier skill with these roles: intake, static safety, compatibility, isolated test orchestration, result verification, performance review, security review, runbook assembly, and promotion gating.
13. Build CI in stages: static policy, metadata validation, SQL 2019 disposable test, SQL 2022 disposable test, Windows-only test lane, Azure SQL lane, and a separately approved destructive test lane.
14. For the first pilot, select ten read-only production candidates. Produce machine-readable evidence for each and do not promote automatically.

Completion criteria:
- No secrets are committed.
- main is protected.
- Static policy runs on every pull request.
- Test credentials are externalized.
- Ten pilot scripts have repeatable isolated test evidence.
- Every promotion requires human review.
- The final report distinguishes installed, configured, deferred, and blocked items.
```

## Recommended tools

| Tool | Decision |
|---|---|
| Codex Security plugin | Configure now with read-only repository scope first |
| Graphify | Pilot now on bounded folders |
| Cloudflare plugin | Defer until hosting architecture is chosen |
| Project-management plugin | Choose exactly one after workflow selection |
| code-review-graph | Defer until the SaaS application has a meaningful code graph |
| Mem0 | Defer until a defensible product-memory requirement exists |
