# frozen_string_literal: true

rabbit_host = ENV.fetch("RABBIT_HOST", "rabbitmq")
rabbit_port = ENV.fetch("RABBIT_PORT", 5672)
Sneakers.configure(
  heartbeat: 30,
  amqp: "amqp://guest:guest@#{rabbit_host}:#{rabbit_port}",
  vhost: "/",
  exchange: "sneakers",
  exchange_type: :direct,
  durable: true
)
