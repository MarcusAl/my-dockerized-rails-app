sidekiq_config = { url: ENV['JOB_WORKER_URL'] }

Sidekiq::Client.reliable_push! unless Rails.env.test?

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
  config.logger.level = Logger::WARN if Rails.env.production?
  config.super_fetch!
end

Sidekiq.strict_args!
