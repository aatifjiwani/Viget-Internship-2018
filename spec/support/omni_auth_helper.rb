OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:default] = { 
  'provider' => 'default',
  'info' => {
    'name' => 'default',
    'email' => 'default@example.com',
    'nickname' => 'Default'
    },
  'extra' => {'raw_info' =>
      { 'location' => 'San Francisco',
        'gravatar_id' => '123456789'
        }
    }
  }

OmniAuth.config.add_mock(:facebook, {
  'provider' => 'facebook',
  'info' => {
    'name' => 'Facebook User',
    'email' => 'facebook@example.com',
    'image' => 'https://upload.wikimedia.org/wikipedia/commons/9/93/Default_profile_picture_%28male%29_on_Facebook.jpg'
    }
  })