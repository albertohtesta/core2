# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

gem 'aws-sdk-cognitoidentity'
gem 'aws-sdk-cognitoidentityprovider'
gem "bootsnap", require: false
gem "jbuilder"
gem "json"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "redis"
gem "sidekiq"
gem "sidekiq-scheduler"
gem "sidekiq-unique-jobs"
gem "sneakers"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "minitest"
end

group :development do
  gem "rubocop"
  gem "rubocop-minitest"
  gem "rubocop-performance"
end

group :test do
  gem "simplecov"
end
