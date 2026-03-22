locals {
  normalized_domain_name = lower(trimspace(var.domain_name))
  www_domain_name        = "${var.www_subdomain}.${local.normalized_domain_name}"

  raw_bucket_prefix = coalesce(
    var.bucket_name_prefix,
    "${var.project_name}-${var.environment}-${local.normalized_domain_name}"
  )

  normalized_bucket_prefix = trim(
    replace(
      replace(lower(local.raw_bucket_prefix), "/[^a-z0-9-]/", "-"),
      "/-+/",
      "-"
    ),
    "-"
  )

  # Keep derived S3 bucket names under the 63 character limit with room for suffixes.
  bucket_prefix        = trim(substr(local.normalized_bucket_prefix, 0, 54), "-")
  site_bucket_name     = "${local.bucket_prefix}-site"
  redirect_bucket_name = "${local.bucket_prefix}-redirect"
  log_bucket_name      = "${local.bucket_prefix}-logs"

  hosted_zone_name = var.hosted_zone_name != null ? trimsuffix(var.hosted_zone_name, ".") : local.normalized_domain_name
  hosted_zone_id   = coalesce(var.hosted_zone_id, try(data.aws_route53_zone.selected[0].zone_id, null))

  common_tags = merge(
    {
      ManagedBy   = "Terraform"
      Project     = var.project_name
      Environment = var.environment
    },
    var.tags
  )
}
