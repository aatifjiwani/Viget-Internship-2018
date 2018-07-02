Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.credentials.dig(:fb_oauth_id), Rails.application.credentials.dig(:fb_oauth_secret), scope: 'email'

  provider :linkedin, Rails.application.credentials.dig(:li_oauth_id), Rails.application.credentials.dig(:li_oauth_secret), scope: 'r_basicprofile r_emailaddress'
end