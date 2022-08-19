# frozen_string_literal: true

ENV["WORKERS"] = Rails.application.config.sneakers.workers.join(",")
Sneakers.configure(
  heartbeat: 30,
  amqp: ENV.fetch("CLOUDAMQP_URL", "amqp://guest:guest@rabbitmq:5672"),
  vhost: "/",
  exchange: ENV.fetch("RABBITMQ_EXCHANGE", "norden"),
  exchange_type: :direct,
  durable: true
)
