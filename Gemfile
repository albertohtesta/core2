# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

gem "aws-sdk-cognitoidentity"
gem "aws-sdk-cognitoidentityprovider"
gem "bootsnap", require: false
gem "bunny"
gem "bunny-mock"
gem "interactor"
gem "jbuilder"
gem "json"
gem "jwt"
gem "kaminari"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-cors"
gem "rails", "~> 7.0.2", ">= 7.0.3.1"
gem "redis"
gem "rswag"
gem "rswag-ui"
gem "rollbar"
gem "sentry-rails"
gem "sentry-ruby"
gem "sidekiq"
gem "sidekiq-scheduler"
gem "sidekiq-unique-jobs"
gem "sneakers"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem "bundler-audit"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "minitest"
  gem "rspec-rails", "~> 6.0.0.rc1"
  gem "rswag-specs"
  gem "byebug"
end

group :development do
  gem "rubocop"
  gem "rubocop-minitest"
  gem "rubocop-performance"
  gem "rubocop-rails_config"
end

group :test do
  gem "simplecov"
  gem "webmock"
end
