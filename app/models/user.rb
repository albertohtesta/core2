# frozen_string_literal: true

# User model
class User < ApplicationRecord
  ROLES = %w[admin collaborator client finance operation]

  serialize :roles, Array

  validates :email, presence: true, uniqueness: true
  validates_presence_of :roles
  validates_inclusion_of :roles, in: ROLES

  def admin?
    roles.include?(ROLES[0])
  end

  def collaborator?
    roles.include?(ROLES[1])
  end

  def client?
    roles.include?(ROLES[2])
  end
end
