# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', github: 'rails/rails', branch: '6-0-stable'
# Use sqlite3 as the database for Active Record
if RUBY_PLATFORM =~ /win32|mingw32/
  gem 'sqlite3', '1.4.0.20190219', platforms: :x64_mingw
else
  gem 'sqlite3', '~> 1.4.0'
end
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sassc-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'duktape'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'activerecord-import'
gem 'awesome_print'
gem 'bootstrap4-kaminari-views'
gem 'httparty'
gem 'kaminari'
gem 'mini_magick'
gem 'pry-rails'
gem 'ransack'
gem 'sidekiq'
gem 'silencer'
gem 'slim-rails'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rails_best_practices'
  gem 'rspec-rails', '~> 4.0.0.beta4'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
end

group :development do
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
