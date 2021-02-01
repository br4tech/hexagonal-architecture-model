# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
gem 'coffee-rails'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Simple, efficient background processing for Ruby
gem 'sidekiq'
# Scheduler / Cron for Sidekiq jobs
gem 'sidekiq-cron'
# Flexible authentication solution for Rails with Warden. http://blog.plataformatec.com.br/tag/…
gem 'devise'
# Create beautiful JavaScript charts with one line of Ruby https://chartkick.com
gem 'chartkick'
# The simplest way to group temporal data
gem 'groupdate'
# Find Brazilian addresses by zipcode, directly from Correios database. No HTML parsers.
gem 'correios-cep'
# Minimal authorization through OO design and pure Ruby classes
gem 'pundit'
# Allow Numeric - A numeric field validation Gem.
gem 'allow_numeric'
# xlsx generation with charts, images, automated column width, customizable
gem  'caxlsx' 
gem  'caxlsx_rails'
# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for modern web app frameworks and ORMs
gem 'kaminari'

gem 'sendgrid-ruby'
gem "aws-sdk-s3"
# gem 'image_processing', '~> 1.2'
gem 'brcobranca', git: 'https://github.com/guigo/brcobranca'
# Cocoon makes it easier to handle nested forms.
gem "cocoon"
# Ransack enables the creation of both simple and advanced search forms for your Ruby on Rails application (demo source code here). If you're looking for something that simplifies query generation at the model or controller layer, you're probably not looking for Ransack (or MetaSearch, for that matter). Try Squeel instead.
gem 'ransack'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'factory_bot_rails'
gem 'faker'

gem 'jquery-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # gem 'pry-rails'
  gem 'rspec-rails', '~> 4.0.0.beta2'
  # Strategies for cleaning databases in Ruby. Can be used to ensure a clean state for testing. http://databasecleaner.github.io
  gem 'database_cleaner'
  # Simple one-liner tests for common Rails functionality https://matchers.shoulda.io
  gem 'shoulda-matchers'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # gem 'mailcatcher', require: false
  gem 'rubocop-rails'
  # Generate Entity-Relationship Diagrams for Rails applications http://voormedia.github.io/rails-erd/
  gem 'rails-erd'
  gem 'pry-rails'
end

group :test do
  gem 'simplecov', require: false
  # gem 'database_cleaner-active_record'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
