# Production Candidate Rules

- Prefer read-only analysis.
- Do not promote files in place. Promotion requires a reviewed pull request with metadata and test evidence.
- Verify target database context, permissions, version compatibility, result shape, runtime, locking, and data exposure.
- A diagnostic query may still be unsafe if it scans large DMVs, plan cache, Query Store, or every database.
