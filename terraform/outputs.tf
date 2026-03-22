output "site_bucket_name" {
  description = "S3 bucket used for canonical site content."
  value       = aws_s3_bucket.site.bucket
}

output "redirect_bucket_name" {
  description = "S3 bucket used for apex redirect website hosting."
  value       = aws_s3_bucket.redirect.bucket
}

output "access_log_bucket_name" {
  description = "S3 bucket used for CloudFront access logs when enabled."
  value       = var.enable_access_logs ? aws_s3_bucket.access_logs[0].bucket : null
}

output "site_distribution_id" {
  description = "CloudFront distribution ID for the canonical site."
  value       = aws_cloudfront_distribution.site.id
}

output "redirect_distribution_id" {
  description = "CloudFront distribution ID for the apex redirect."
  value       = aws_cloudfront_distribution.redirect.id
}

output "canonical_url" {
  description = "Canonical frontend URL."
  value       = "https://${local.www_domain_name}"
}

output "apex_url" {
  description = "Apex URL that redirects to the canonical hostname."
  value       = "https://${local.normalized_domain_name}"
}

output "hosted_zone_id" {
  description = "Resolved Route53 hosted zone ID used by this stack."
  value       = local.hosted_zone_id
}
