# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module ImageDb
  def self.images_path=(path)
    @images_path = path
  end

  def self.images_path
    @images_path ||= Rails.root.join('public', 'images')
  end

  def self.thumbs_path=(path)
    @thumbs_path = path
  end

  def self.thumbs_path
    @thumbs_path ||= Rails.root.join('public', 'thumbs')
  end

  class Application < Rails::Application
    config.load_defaults 5.2
    config.active_job.queue_adapter = :sidekiq
  end
end
