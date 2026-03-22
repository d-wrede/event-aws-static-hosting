variable "aws_region" {
  description = "Primary AWS region for S3 and Route53-related resources."
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Short project identifier used for naming and tagging."
  type        = string
}

variable "environment" {
  description = "Environment name used for naming and tagging."
  type        = string
  default     = "production"
}

variable "domain_name" {
  description = "Canonical apex domain, for example example.com."
  type        = string
}

variable "www_subdomain" {
  description = "Subdomain used for the canonical frontend hostname."
  type        = string
  default     = "www"
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID. Set this or hosted_zone_name."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = (var.hosted_zone_id == null) != (var.hosted_zone_name == null)
    error_message = "Set exactly one of hosted_zone_id or hosted_zone_name."
  }
}

variable "hosted_zone_name" {
  description = "Route53 hosted zone name, for example example.com. Set this or hosted_zone_id."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = (var.hosted_zone_id == null) != (var.hosted_zone_name == null)
    error_message = "Set exactly one of hosted_zone_id or hosted_zone_name."
  }
}

variable "bucket_name_prefix" {
  description = "Optional explicit prefix for S3 bucket names. When omitted, a prefix is derived from project, environment, and domain."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.bucket_name_prefix == null || length(trimspace(var.bucket_name_prefix)) > 0
    error_message = "bucket_name_prefix must not be empty when set."
  }

  validation {
    condition     = var.bucket_name_prefix == null || length(regexall("[A-Za-z0-9]", var.bucket_name_prefix)) > 0
    error_message = "bucket_name_prefix must contain at least one letter or digit when set."
  }
}

variable "enable_access_logs" {
  description = "Whether to create an S3 bucket and enable CloudFront access logs."
  type        = bool
  default     = false
}

variable "site_default_ttl" {
  description = "Default TTL in seconds for the canonical site distribution."
  type        = number
  default     = 300
}

variable "site_max_ttl" {
  description = "Maximum TTL in seconds for the canonical site distribution."
  type        = number
  default     = 86400
}

variable "redirect_default_ttl" {
  description = "Default TTL in seconds for the apex redirect distribution."
  type        = number
  default     = 3600
}

variable "redirect_max_ttl" {
  description = "Maximum TTL in seconds for the apex redirect distribution."
  type        = number
  default     = 86400
}

variable "price_class" {
  description = "CloudFront price class."
  type        = string
  default     = "PriceClass_100"

  validation {
    condition = contains(
      ["PriceClass_100", "PriceClass_200", "PriceClass_All"],
      var.price_class
    )
    error_message = "price_class must be one of PriceClass_100, PriceClass_200, or PriceClass_All."
  }
}

variable "tags" {
  description = "Additional tags merged into the repository defaults."
  type        = map(string)
  default     = {}
}
