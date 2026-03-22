# AGENTS.md

Primary repository instructions for local agents working in this repository.

## Repository intent

This repository is for a narrow outcome:

- reproducible infrastructure for static hosting
- HTTPS-ready delivery for the final domain
- clean handling for `apex` and `www`
- redirects and baseline caching
- strict separation between infrastructure and content/data deployment

Use `freiburg-hosting-repo-analysis.md` as the current architectural intent reference until a fuller project documentation structure exists.

## Instruction precedence

When instructions overlap, use this order:

1. `AGENTS.md`
2. `.github/copilot-instructions.md`
3. `README.md`
4. `freiburg-hosting-repo-analysis.md`

If a new repo document is added later and should become authoritative, update this section explicitly.

## File responsibilities

- `AGENTS.md`
  Local default instructions for this repository.
  Defines scope, workflow, guardrails, and documentation precedence.
- `.github/copilot-instructions.md`
  Entry point for cloud agents and repo automation.
  Keep AWS-, Terraform-, CI-, and deployment-platform-specific rules there.
- `freiburg-hosting-repo-analysis.md`
  Planning and target-state reference.
  Use it to keep implementation aligned with the intended hosting scope.

## Core guardrails

- Keep changes small, reviewable, and in scope.
- Do not import patterns from the reference repository unless they directly support the static-hosting target.
- Do not mix infrastructure provisioning with frontend artifact upload or content deployment.
- Do not hard-code environment-specific values such as domain names, hosted zone IDs, bucket names, certificate ARNs, account IDs, or local filesystem paths when Terraform variables or documented inputs are the right model.
- Prefer reproducibility over convenience shortcuts.
- Do not add unrelated platform concerns such as Lambda, API Gateway, SES, databases, or application backends unless explicitly requested.

## Infrastructure expectations

- Prefer Terraform as the infrastructure definition layer.
- Keep the infrastructure surface focused on:
  - DNS / Route53 integration
  - ACM certificates for CloudFront
  - S3 buckets for static site and redirect behavior
  - CloudFront distributions
  - optional logging resources
- `www` serving and `apex` redirect should be modeled as separate concerns.
- Make caching decisions explicit instead of leaving important behavior at unclear defaults.
- Production-destructive settings such as `force_destroy = true` should not be the default without an explicit reason.

## Separation of concerns

- Infrastructure code may create hosting resources, policies, certificates, and DNS records.
- Infrastructure code should not upload site contents from a developer machine.
- If deployment guidance is added later, document infrastructure apply and content publish as separate workflows.

## Local workflow

- Before editing, inspect the current repository state and existing instructions.
- Prefer minimal diffs over broad rewrites.
- Preserve unrelated user changes.
- Do not touch secrets or local environment files if they appear later, including `.env`, `*.tfvars`, or credential files, unless the user explicitly asks for it.
- Do not commit generated artifacts, Terraform state files, plan files, or logs.

## Testing and validation

This repository does not yet define a canonical local test command.

Until one exists:

- validate the changed files with the smallest relevant command set
- prefer Terraform-oriented validation for Terraform changes, such as `terraform fmt -check` and `terraform validate`, when the tooling and configuration are present
- avoid claiming full verification if only a partial validation was possible

If later the repository introduces CI-only checks or a canonical local script, document the difference explicitly:

- local agent workflow belongs in `AGENTS.md`
- cloud/CI workflow belongs in `.github/copilot-instructions.md`

## Git policy for local agents

Allowed read-only git commands:

- `git status`
- `git diff`
- `git diff --staged`
- `git show <rev>`
- `git log`
- `git log --oneline --decorate --graph`
- `git branch`
- `git branch -a`
- `git rev-parse --abbrev-ref HEAD`
- `git remote -v`
- `git ls-files`
- `git blame <file>`

Do not run git commands that modify the working tree, index, refs, or history unless the user explicitly asks for them.

If the user explicitly asks for staging or committing:

- stage only explicit paths
- keep commits narrowly scoped
- use Conventional Commits subjects in English

## Completion reporting

When finishing work, report:

- what changed
- what validation was run
- any remaining gaps or assumptions

If no meaningful validation could be run, say so plainly and state why.
