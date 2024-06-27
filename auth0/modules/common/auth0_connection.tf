# ----------------------------------------------------------------
# Social LINE
# ----------------------------------------------------------------

resource "auth0_connection" "social_line" {
  name     = "line"
  strategy = "line"
  options {
    scopes         = ["openid", "profile"]
    #email          = false
    #profile        = true
    client_id     = var.line_client_id
    client_secret = var.line_client_secret
  }
}

# ----------------------------------------------------------------
# Social Yahoo Japan (Custom OAuth2)
# ----------------------------------------------------------------

resource "auth0_connection" "social_yahoo_japan" {
  name         = "yahoo-japan"
  display_name = "Yahoo! Japan"
  strategy     = "oauth2"
  options {
    scopes                 = ["openid", "profile", "email"]
    icon_url               = var.yahoo_japan_icon_url
    authorization_endpoint = "https://auth.login.yahoo.co.jp/yconnect/v2/authorization"
    token_endpoint         = "https://auth.login.yahoo.co.jp/yconnect/v2/token"
    client_id              = var.yahoo_japan_client_id
    client_secret          = var.yahoo_japan_client_secret
    scripts = {
      fetchUserProfile = file("../../connections/social-custom-yahoo-japan.js")
    }
  }
}
