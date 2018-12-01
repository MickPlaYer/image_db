# frozen_string_literal: true

Rails.application.configure do
  config.active_job.logger = Sidekiq.logger if Sidekiq.server?
end

Sidekiq.logger.level = Logger::DEBUG if Rails.env.development?
