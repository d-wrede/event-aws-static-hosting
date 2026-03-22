# Event AWS Static Hosting

Terraform repository for a narrow hosting outcome:

- reproducible static hosting infrastructure
- HTTPS-ready delivery for the final domain
- explicit `apex` and `www` handling
- baseline caching and redirect behavior
- strict separation between infrastructure and content deployment

## Repository layout

- `terraform/`: infrastructure code
- `terraform/envs/`: example environment inputs
- `docs/deployment.md`: deployment workflow and operating notes

## Scope

This repository intentionally covers only:

- Route53 integration
- ACM certificate management for CloudFront
- S3 buckets for site and redirect behavior
- optional S3 access logging
- CloudFront distributions for `www` and `apex`

It does not upload frontend artifacts and does not include application backends.

The canonical hostname is `www.<domain>`. The apex domain remains reachable and redirects to the canonical hostname.

## Getting started

1. Review `AGENTS.md`, `.github/copilot-instructions.md`, and `docs/deployment.md`.
2. Copy `terraform/envs/production.tfvars.example` to a real `.tfvars` file outside version control or to a local ignored file.
3. Initialize and apply Terraform from `terraform/`.

Example:

```bash
terraform -chdir=terraform init
terraform -chdir=terraform plan -var-file=envs/production.tfvars
terraform -chdir=terraform apply -var-file=envs/production.tfvars
```

See `docs/deployment.md` for the expected deployment split between infrastructure and content publishing.
