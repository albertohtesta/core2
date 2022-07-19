# frozen_string_literal: true

# Base class for repositories
class UserRepository < ApplicationRepository
  def self.ordered_by_email
    User.order(email: :asc)
  end
end
