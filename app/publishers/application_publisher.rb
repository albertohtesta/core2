# frozen_string_literal: true

# Base class for publishers
class ApplicationPublisher
  SchemaError = Class.new(StandardError)

  class << self
    def direct_to(route_name, persistent: true)
      self.route_name = route_name
      self.persistent = persistent
    end

    def publish(message, **args)
      validate(message)
      new(**args).publish(message)
    end

    def validate(message)
      errors = []
      message = message.with_indifferent_access

      self::SCHEMA.each do |attribute, allowed_classes|
        next if allowed_classes.include?(message[attribute].class)

        errors << "value #{attribute}: #{message[attribute]} is not in allowed classes #{allowed_classes}"
      end

      if errors.any?
        raise SchemaError.new(errors)
      end
    end
  end

  class_attribute :route_name, :persistent

  def initialize(conn: RABBIT_MQ)
    @conn = conn.start
  end

  def publish(message)
    exchange.publish(
      message.to_json,
      routing_key: queue.name,
      persistent:
    )
    @conn.close
  end

  protected

  def exchange
    @exchange ||= channel.direct(
      ENV.fetch("RABBITMQ_EXCHANGE", "norden"),
      durable: true
    )
  end

  def channel
    @channel ||= conn.create_channel
  end

  def queue
    @queue ||= channel.queue(route_name, durable: true)
  end

  private

  attr_reader :conn
end
