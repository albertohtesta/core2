# frozen_string_literal: true

ENV["WORKERS"] = Rails.application.config.sneakers.workers.join(",")
Sneakers.configure(
  heartbeat: 30,
  amqp: Rails.application.config.sneakers.amqp_url,
  vhost: ,
  exchange: Rails.application.config.sneakers.vhost,
  exchange_type: :direct,
  durable: true,
  workers: Rails.application.config.sneakers.max_workers,
  threads: Rails.application.config.sneakers.max_threads
)
