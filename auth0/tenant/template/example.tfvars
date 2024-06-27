# Auth0 Provider Settings
domain        = "AUTH0_DOMAIN"
client_id     = "AUTH0_MANAGEMENT_API_CLIENT_ID"
client_secret = "AUTH0_MANAGEMENT_API_CLIENT_SECRET"

# User Settings
demo_users = [
  {
    email        = "DEMO_USER_EMAIL_ADDRESS_0"
    given_name   = "DEMO_USER_FIRST_NAME_0"
    family_name  = "DEMO_USER_LAST_NAME_0"
    user_metadata = {
      require_mfa = false
    }
    app_metadata = {
      KEY = "VALUE"
    }
  },
  {
    email        = "DEMO_USER_EMAIL_ADDRESS_1"
    given_name   = "DEMO_USER_FIRST_NAME_1"
    family_name  = "DEMO_USER_LAST_NAME_1"
    user_metadata = {
      require_mfa = false
    }
    app_metadata = {
      KEY = "VALUE"
    }
  },
  {
    email        = "DEMO_USER_EMAIL_ADDRESS_2"
    given_name   = "DEMO_USER_FIRST_NAME_2"
    family_name  = "DEMO_USER_LAST_NAME_2"
    user_metadata = {
      require_mfa = false
    }
    app_metadata = {
      KEY = "VALUE"
    }
  }
]
demo_user_password  = "DEMO_USER_PASSWORD"
database_connection = "DATABASE_CONNECTION"

# Social Connection
yahoo_japan_client_id     = "YAHOO_JAPAN_CLIENT_ID"
yahoo_japan_client_secret = "YAHOO_JAPAN_CLIENT_SECRET"
yahoo_japan_icon_url      = "YAHOO_JAPAN_ICON_URL"

line_client_id     = "LINE_CLIENT_ID"
line_client_secret = "LINE_CLIENT_SECRET"
