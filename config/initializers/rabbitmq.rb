# frozen_string_literal: true

require "bunny-mock"

if Rails.env.test?
  RABBIT_MQ = BunnyMock.new
else
  RABBIT_MQ = Bunny.new(
    ENV.fetch("CLOUDAMQP_URL", "amqp://guest:guest@rabbitmq:5672")
  )
end
