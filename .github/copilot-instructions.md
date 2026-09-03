# SQL Server DBA Library — Copilot Working Instructions

These instructions apply to every Copilot interaction in this workspace. They supplement `AGENTS.md` (the authoritative contract) and the governance docs under `docs/`. Read `AGENTS.md` first.

## Scope

This repository contains SQL Server DBA scripts organized by trust tier:

- `20-Production-Candidates` — candidates, **not** certified
- `40-Controlled-Change-Scripts` — requires change control
- `99-Quarantine` — **blocked from all execution**, automated or otherwise
- `metadata/script.schema.json` — the metadata contract for promotion

## Default posture

Default to **read-only inspection**. A request to review, classify, or "verify" a script is **not** authorization to execute it.

## Verification workflow (per script)

When asked to verify a SQL script, follow this sequence. Stop and ask the user before advancing between phases.

### Phase 1 — Intake and static analysis (always allowed, no execution)

1. Identify the script's path, provenance (source, author if known), and trust tier from its folder.
2. Run the static policy check scoped to the script if possible: `pwsh ./tools/Test-SqlScriptPolicy.ps1`.
3. Read the script and report, in a concise structured form:
   - Purpose and intended outcome (inferred, flagged as inference if not documented).
   - Required SQL Server version/edition features used (e.g., `DATABASEPROPERTYEX`, contained AG, `OPTIMIZE_FOR_ADHOC_WORKLOADS`).
   - Destructive/high-risk statements found: `KILL`, `DROP`, `TRUNCATE`, `RESTORE`, `xp_cmdshell`, cache clearing, forced offline, failover, TDE, replication teardown, filesystem operations.
   - Embedded credentials, connection strings, hardcoded server/instance names, environment-specific paths — flag any as **blockers**.
   - Parameterization: does it accept parameters, or hardcode values?
   - Idempotency: can it be re-run safely? Document evidence or uncertainty.
   - Transaction/rollback behavior.
   - Expected lock/IO/CPU footprint at a glance (qualitative).
4. Produce a draft metadata entry conforming to `metadata/script.schema.json` with anything unknown left as `TODO`. Never invent values.
5. Decide and report one of: **quarantine-blocked**, **needs-fixes**, **candidate-for-testing**.

### Phase 2 — Test planning (requires explicit user approval to proceed)

Before any execution, present to the user and get approval for:

- Target: only disposable containers from `docker-compose.test.yml` (SQL Server 2019 / 2022 profiles). Never production. Never an ad-hoc instance without the user stating it explicitly.
- Expected state changes, observable success criteria, rollback/cleanup steps, and required permissions (least-privileged test identity).
- How before/after state will be captured.

### Phase 3 — Execution and evidence (only after approval)

1. Execute only in the approved disposable container.
2. Capture: exit state, messages, result sets, duration, before/after state, and any errors.
3. Test repeat execution to confirm idempotency claim.
4. Record results as evidence (a report file or structured output), not by editing the source script.
5. Re-run `pwsh ./tools/Test-SqlScriptPolicy.ps1`.

### Phase 4 — Promotion recommendation (human decides)

Summarize per `docs/PROMOTION-POLICY.md` and `docs/SCRIPT-REVIEW-CHECKLIST.md`:

- Metadata complete per schema — yes/no/gaps
- Static policy — pass/fail
- Declared supported targets
- Disposable-instance test results
- Documented permissions and workload impact
- Idempotency evidence
- Before/after capture
- Rollback/cleanup demonstrated
- Remaining uncertainties

End with: "Recommended: promote / hold / quarantine — awaiting human approval." Never promote from filename analysis or a single successful run.

## Hard rules (never violate)

- Never execute anything from `99-Quarantine`.
- Never add plaintext credentials, tokens, connection strings, private keys, customer identifiers, internal endpoints, or public-IP allowlists to any file.
- Never connect tests to production.
- Never treat folder location or filename as certification.
- Preserve third-party filenames, attribution, licenses, package ordering.
- Don't suppress a failing policy rule without documenting the reason and obtaining review.
- Generated test results are evidence, not source code.

## Token-friendly working style

- Prefer `grep`/`glob`/targeted `view` ranges over reading whole files; use `view_range` for large files.
- Use the code-review-graph MCP tools (blast radius, impact, review context) when available to avoid re-reading unrelated code.
- Summarize long outputs; don't paste full stack traces unless asked.
- Batch parallel tool calls when reading multiple independent files.

## Validation command

Run `pwsh ./tools/Test-SqlScriptPolicy.ps1` before committing SQL or PowerShell changes.
