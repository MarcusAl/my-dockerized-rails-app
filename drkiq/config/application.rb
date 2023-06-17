require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Drkiq
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_record.schema_format = :ruby
    
    config.log_level = :debug
    config.log_tags  = [:subdomain, :uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    
    config.cache_store = :redis_store, ENV['CACHE_URL'],
    { namespace: 'drkiq::cache' }
    
    config.active_job.queue_adapter = :sidekiq
    
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # Make all migrations use uuid as primary key type
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    # Do not encode ">" => '\u003e', "<" => '\u003c', "&" => '\u0026' in
    # [to_json](https://github.com/rails/rails/blob/7-0-stable/activesupport/lib/active_support/json/encoding.rb#L55).
    config.active_support.escape_html_entities_in_json = false

    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
