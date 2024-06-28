resource "okta_group" "demo_group" {
  name        = "Demo Terraform"
  description = "Demo group by Okta Terraform"
}

resource "okta_group_memberships" "demo_group_membership" {
  group_id = okta_group.demo_group.id
  users = [for user in okta_user.demo_user : user.id]
}

resource "okta_app_group_assignments" "demo_group_assignments" {
  for_each = { for i,v in okta_app_oauth.demo_app_oauth : i=>v }
  app_id   = each.value.id
  group {
    id = okta_group.demo_group.id
    priority = 1
  }
}


resource "okta_group" "sales" {
  name        = "Sales"
  description = "Sales group"
}

resource "okta_group_rule" "sales_member" {
  name   = "Sales members"
  status = "ACTIVE"
  group_assignments = [okta_group.sales.id]
  expression_type  = "urn:okta:expression:1.0"
  expression_value = "user.department==\"Sales\""
}


resource "okta_group" "contractor" {
  name        = "Contractor"
  description = "Contractor group"
}

resource "okta_group_rule" "contractor" {
  name   = "Contractors"
  status = "ACTIVE"
  group_assignments = [okta_group.contractor.id]
  expression_type  = "urn:okta:expression:1.0"
  expression_value = "user.userType==\"Contractor\""
}
