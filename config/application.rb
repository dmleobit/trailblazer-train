require_relative 'boot'

require 'rails'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'

Bundler.require(*Rails.groups)

module OdinTask
  class Application < Rails::Application
    config.load_defaults 6.0
  end
end
