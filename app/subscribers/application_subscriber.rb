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
    @permitted_attributes ||= self.class::ATTRS.keys.each_with_object({}) do |key, memo|
      memo[key] = attribute(key)
      memo
    end
  end

  def attribute(key)
    attributes[self.class::ATTRS[key]]
  end

  def attributes(content)
    @attributes ||= JSON.parse(content, symbolize_names: true)
  end
end
