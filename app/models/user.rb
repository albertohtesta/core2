# frozen_string_literal: true

# User model
class User < ApplicationRecord
  ROLES = %w[admin collaborator client]

  serialize :roles, Array

  validates :email, presence: true, uniqueness: true
  validates_presence_of :roles
  validates_inclusion_of :roles, in: ROLES

  def admin?
    roles.include?(ROLES[0])
  end
end
