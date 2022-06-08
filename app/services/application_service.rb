# frozen_string_literal: true

class ApplicationService
  def self.for(*args)
    new(*args).process
  end
end
