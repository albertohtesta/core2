# frozen_string_literal: true

# Base class for subscribers
class ApplicationSubscriber < ApplicationJob
  include Sneakers::Worker
  from_queue :default

  ATTRS = {}.freeze

  def perform(payload)
    @payload = safe_json(payload)
    process
  end

  protected

  def permitted_attributes
    self.class::ATTRS.keys.each_with_object({}) do |key, memo|
      memo[key] = attribute(key)
      memo
    end
  end

  def attribute(key)
    @payload[self.class::ATTRS[key]]
  end

  def safe_json(content)
    JSON.parse(content, symbolize_names: true)
  rescue JSON::ParserError
    {}
  end
end
