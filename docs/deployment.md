# Deployment Notes

## Intent

Infrastructure provisioning and frontend artifact publishing are separate workflows.

This repository creates hosting resources only:

- certificate
- DNS records
- buckets
- CloudFront distributions
- optional access logging

It does not upload site files from a developer machine.

## Typical workflow

1. Apply Terraform infrastructure from the `terraform/` subdirectory.
2. Publish frontend artifacts to the site bucket using a separate deployment workflow.
3. Invalidate CloudFront paths when the publishing workflow requires it.

Example:

```bash
terraform -chdir=terraform init
terraform -chdir=terraform plan -var-file=envs/production.tfvars
terraform -chdir=terraform apply -var-file=envs/production.tfvars
```

## Expected prerequisites

- AWS credentials with permissions for Route53, ACM, S3, and CloudFront
- ownership or delegated control of the target Route53 hosted zone
- final domain decision before production apply

## Operational notes

- The ACM certificate is created in `us-east-1` because CloudFront requires it there.
- `www.<domain>` is the canonical frontend hostname.
- `<domain>` is handled separately and redirects to `https://www.<domain>`.
- The site distribution uses a CloudFront Function on `viewer-request` to rewrite clean subpage URLs such as `/info` and `/info/` to `/info/index.html` while leaving asset paths unchanged.
- Cache behavior is explicit in Terraform rather than relying on unclear defaults.
- Terraform provisions hosting infrastructure only. Frontend artifact publishing remains a separate workflow by design.
