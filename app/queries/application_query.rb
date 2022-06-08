# frozen_string_literal: true

class ApplicationQuery
  def initialize(*args); end

  def self.execute(*args)
    new.execute(*args)
  end
end
