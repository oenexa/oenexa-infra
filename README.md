# OENEXA Infrastructure as Code (`oenexa-infra`)

> **Enterprise Infrastructure as Code (IaC) & Cloud Foundation Repository**  
> Governed by the OENEXA Infrastructure & Cloud Architecture Teams.

## 1. Principles
- **100% Declarative**: No cloud infrastructure, DNS record, VPC, or database may exist outside this repository.
- **Strict Domain Isolation**: Every business domain receives an independent, isolated database instance. Cross-database queries or shared databases are strictly forbidden.
- **Zero Drift**: Continuous Terraform plan validation in CI; any out-of-band changes are automatically alerted and remediated.

## 2. Directory Layout
```text
oenexa-infra/
└── terraform/
    ├── modules/
    │   ├── vpc/                 # Multi-AZ VPC, subnets, NAT gateways
    │   ├── kubernetes/          # Managed Kubernetes cluster
    │   ├── database-postgres/   # Isolated per-domain Postgres module
    │   └── cloudflare-dns/      # Canonical DNS records & WAF
    └── environments/
        ├── prod/                # Production environment root module
        └── staging/             # Staging environment root module
```
