# frozen_string_literal: true

class ApplicationPublisher
  class << self
    def direct_to(route_name)
      self.route_name = route_name
    end

    def publish(message, **args)
      new(**args).publish(message)
    end
  end

  class_attribute :route_name

  def initialize(conn: RABBIT_MQ)
    @conn = conn
  end

  def publish(message)
    exchange.publish(message.to_json, routing_key: route_name)
  end

  protected

  def exchange
    @exchange ||= channel.direct("amq.direct")
  end

  def channel
    @channel ||= conn.create_channel
  end

  private

  attr_reader :conn
end
