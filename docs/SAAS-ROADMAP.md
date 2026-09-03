# SQL Monitoring SaaS Roadmap

## Decisions required before implementation

- Agent-based versus agentless collection
- Supported SQL Server and Azure platforms
- Tenant isolation and encryption boundaries
- Credential and identity model
- Collection intervals, retention, aggregation and cost
- Query-text and PII handling
- Alert-quality metrics and suppression
- Advisory-only versus automated remediation
- Regional deployment and compliance requirements

## Recommended phases

1. Define telemetry and tenant contracts.
2. Build a local single-tenant collector proof of concept.
3. Validate failure handling and backpressure.
4. Add multi-tenant control plane and strict isolation.
5. Add alert evaluation and evidence-based recommendations.
6. Add AI explanation only after deterministic monitoring is trustworthy.
