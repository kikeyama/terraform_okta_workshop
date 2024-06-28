resource "okta_user" "demo_user" {
  for_each     = { for u in var.okta_users : u.email => u }
  first_name   = each.value.first_name
  last_name    = each.value.last_name
  display_name = "${each.value.first_name} ${each.value.last_name}"
  nick_name    = split("@", each.value.email)[0]
  email        = each.value.email
  password     = var.demo_user_password
  login        = each.value.email
  department   = each.value.department
  user_type    = each.value.user_type
}
