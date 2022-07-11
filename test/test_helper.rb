# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

if ENV["CI"]
  require "simplecov"
  SimpleCov.start "rails"
  puts "required simplecov"
end

require_relative "../config/environment"
require "rails/test_help"
require "minitest/autorun"
require "webmock/minitest"

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
    include WebmockHelper
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
