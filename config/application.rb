# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module ImageDb
  def self.images_path
    Rails.root.join 'images'
  end

  class Application < Rails::Application
    config.load_defaults 5.2
  end
end
