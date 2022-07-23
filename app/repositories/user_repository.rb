# frozen_string_literal: true

# Base class for repositories
class UserRepository < ApplicationRepository
  def self.ordered_by_email
    scope.order(email: :asc)
  end

  def self.find_by_email(email)
    scope.find_by(email:)
  end
end
