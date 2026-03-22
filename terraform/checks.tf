check "hosted_zone_input" {
  assert {
    condition     = (var.hosted_zone_id == null) != (var.hosted_zone_name == null)
    error_message = "Set exactly one of hosted_zone_id or hosted_zone_name."
  }
}
