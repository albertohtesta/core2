require "bunny-mock"

CONN = Bunny.new(ENV.fetch("CLOUDAMQP_URL", "amqp://guest:guest@rabbitmq:5672")).tap(&:start)
RABBIT_MQ = CONN
