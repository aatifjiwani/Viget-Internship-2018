Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.credentials.dig(:fb_oauth_id), Rails.application.credentials.dig(:fb_oauth_secret),
    scope: 'email,user_birthday,user_location,user_hometown'
end