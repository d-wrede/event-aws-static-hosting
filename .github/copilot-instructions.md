# Copilot entry point for this repository

Start with `AGENTS.md`. It is the primary instruction file for this repository.

Use this file for cloud-side, CI-side, and Terraform/AWS-specific constraints that should remain separate from local agent workflow guidance.

## Repository target

The intended outcome is deliberately narrow:

- reproducible infrastructure for static hosting
- final domain reachable via HTTPS
- clean handling of `apex` and `www`
- redirects and baseline caching
- clear separation between infrastructure and content/data deployment

## Agent entry sequence

1. Read `AGENTS.md` first.
2. Read this file second for cloud-specific constraints.
3. Read `README.md` and `docs/deployment.md` when implementation scope or repository shape is relevant.

## Cloud and Terraform guardrails

- Prefer Terraform for infrastructure definitions.
- Keep the repository focused on static hosting infrastructure.
- Do not introduce unrelated platform components such as Lambda, API Gateway, SES, databases, or application backends unless explicitly requested.
- Do not couple Terraform apply with local content upload steps.
- Do not embed developer-machine paths or account-specific one-off values into the infrastructure code.
- Parameterize environment-specific values such as domain names, hosted zone IDs, certificate references, tags, and bucket names.

## AWS-specific expectations

- CloudFront certificates must be handled in `us-east-1`.
- `www` delivery and `apex` redirect should be modeled cleanly and explicitly.
- Route53 records, certificate validation, buckets, and distributions should be reproducible from repository inputs.
- Baseline caching and redirect behavior should be intentional and documented in code or accompanying docs.
- Risky production defaults such as bucket destruction should require explicit justification.

## CI and verification

- Local validation instructions belong in `AGENTS.md`.
- Cloud or CI workflows may be stricter than local workflows; if both exist, keep the distinction explicit instead of implying they are identical.
- Do not rely on shell piping that can mask failures in CI-oriented verification steps.

## Documentation rule

If new repository documentation is added later, keep responsibilities separated:

- `AGENTS.md` for local agent workflow and general repository policy
- `.github/copilot-instructions.md` for cloud automation and platform-specific constraints
- feature or architecture documents for implementation detail
