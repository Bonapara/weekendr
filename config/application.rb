require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Weekendr
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Config de sidekiq pour mettre les call de l'API dans la queue des taches a realiser
    config.active_job.queue_adapter = :sidekiq
    # Config language
    config.i18n.default_locale = :fr


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
