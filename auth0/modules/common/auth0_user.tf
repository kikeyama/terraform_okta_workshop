resource "auth0_user" "demo_user" {
  for_each        = { for u in var.demo_users : "${u.email}" => u }
  connection_name = var.database_connection
  name            = "${each.value.given_name} ${each.value.family_name}"
  given_name      = each.value.given_name
  family_name     = each.value.family_name
  nickname        = split("@", each.value.email)[0]
  email           = each.value.email
  email_verified  = true
  password        = var.demo_user_password
  app_metadata    = jsonencode(each.value.app_metadata)
}
