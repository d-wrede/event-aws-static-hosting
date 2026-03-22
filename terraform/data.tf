data "aws_route53_zone" "selected" {
  count = var.hosted_zone_id == null ? 1 : 0

  name         = "${local.hosted_zone_name}."
  private_zone = false
}
