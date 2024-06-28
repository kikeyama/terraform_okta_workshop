resource "okta_app_signon_policy" "demo_authentication_policy" {
  name        = "Demo Authentication Policy"
  description = "Demo Authentication Policy managed by Terraform"
}

resource "okta_app_signon_policy_rule" "contractor" {
  policy_id = okta_app_signon_policy.demo_authentication_policy.id
  name      = "Contractor"
  status    = "ACTIVE"
  priority  = 1

  groups_included = [
    okta_group.contractor.id,
  ]

  access                      = "ALLOW"
  factor_mode                 = "2FA"
  re_authentication_frequency = "PT0S"
  constraints = [
    jsonencode({
      "knowledge" : {
        "reauthenticateIn" : "PT1H",
        "types" : ["password"]
      },
      "possession" : {
        "deviceBound" : "REQUIRED",
        "hardwareProtection" : "REQUIRED",
        "userPresence" : "OPTIONAL"
      }
    })
  ]
}
