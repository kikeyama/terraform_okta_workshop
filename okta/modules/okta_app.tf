resource "okta_app_oauth" "demo_app_oauth" {
  count                 = var.app_count
  label                 = "Demo ${substr(format("00%s", count.index), -3, -1)}"
  type                  = "web"
  grant_types           = ["authorization_code"]
  redirect_uris         = ["https://example.com/callback"]
  response_types        = ["code"]
  authentication_policy = okta_app_signon_policy.demo_authentication_policy.id
}
