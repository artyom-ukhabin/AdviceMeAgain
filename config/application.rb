require_relative 'boot'

require 'rails/all'
require 'elasticsearch/persistence/model'
require 'sidekiq/web'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AdviceMeAgain
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.app_generators.scaffold_controller = :scaffold_controller
    Rails.application.config.active_record.belongs_to_required_by_default = true
  end
end
