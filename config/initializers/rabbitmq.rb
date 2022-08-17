# frozen_string_literal: true

require "bunny-mock"

CONN = Rails.env.test? ? BunnyMock.new.start : Bunny.new(ENV.fetch("CLOUDAMQP_URL", "amqp://guest:guest@rabbitmq:5672")).tap(&:start)
RABBIT_MQ = CONN
