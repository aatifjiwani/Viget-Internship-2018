require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Viget
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
      
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
        html_tag
    }  

    config.autoload_paths += %W(#{config.root}/lib/classes)
    config.autoload_paths += Dir["#{config.root}/lib/classes/**/"]
    
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
