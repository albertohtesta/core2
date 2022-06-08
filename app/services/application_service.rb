# frozen_string_literal: true

# Base class for services
class ApplicationService
  def self.for(*args)
    new(*args).process
  end
end
