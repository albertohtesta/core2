# frozen_string_literal: true

require "sneakers"

# Base class for subscribers
class ApplicationSubscriber
  include Sneakers::Worker
  from_queue :default, ack: true

  ATTRS = {}.freeze

  def work(payload)
    @payload = payload
    process rescue requeue! if permitted_attributes
    ack!
  end

  protected

  def permitted_attributes
    self.class::ATTRS.keys.each_with_object({}) do |key, permitted_payload|
      permitted_payload[key] = value(key)
      permitted_payload
    end
  end

  def value(key)
    parsed_payload[self.class::ATTRS[key]]
  end

  def parsed_payload
    JSON.parse(@payload, symbolize_names: true)
  end
end
