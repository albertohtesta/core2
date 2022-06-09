# frozen_string_literal: true

Sneakers.configure  heartbeat: 30,
                    amqp: "amqp://guest:guest@#{ENV.fetch("RABBIT_HOST")}:#{ENV.fetch("RABBIT_PORT")}",
                    vhost: "/",
                    exchange: "sneakers",
                    exchange_type: :direct
