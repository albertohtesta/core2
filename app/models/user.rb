# frozen_string_literal: true

# User model
class User < ApplicationRecord
  enum role: [:admin, :collaborator]
  validates :email, presence: true, uniqueness: true
end
