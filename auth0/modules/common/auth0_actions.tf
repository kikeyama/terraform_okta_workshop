resource "auth0_action" "custom_mfa" {
  name    = "Custom MFA"
  runtime = "node18"
  deploy  = true
  code    = file("../../actions/Custom-MFA.js")

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }
}
