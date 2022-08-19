# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CoreBackend
  # Base class for application
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.sneakers = config_for(:sneakers)
  end
end
