locals {
  normalized_domain_name = lower(trimspace(var.domain_name))
  www_domain_name        = "${var.www_subdomain}.${local.normalized_domain_name}"

  derived_bucket_prefix = lower(
    replace(
      replace(
        replace("${var.project_name}-${var.environment}-${local.normalized_domain_name}", ".", "-"),
        "_",
        "-"
      ),
      " ",
      "-"
    )
  )

  bucket_prefix        = coalesce(var.bucket_name_prefix, local.derived_bucket_prefix)
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
