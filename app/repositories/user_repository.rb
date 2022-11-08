# frozen_string_literal: true

# Base class for repositories
class UserRepository < ApplicationRepository
  def self.ordered_by_email
    scope.order(email: :asc)
  end

  def self.find_by_email(email)
    scope.find_by(email:)
  end

  def self.filter_by_role_email_and_not_collaborators(role:, email:)
    scope.where("email LIKE ?", "%#{email}%")
         .where("roles LIKE ?", "%#{role}%")
         .where.not("roles LIKE ?", "%collaborator%")
         .order(email: :asc)
  end

  def self.filter_by_role_email(role:, email:)
    if email.present?
      scope.where("roles LIKE ? or roles LIKE ? or roles LIKE ? or roles LIKE ?",
        "%admin%", "%finance%", "%operation%", "%client").
      where("email LIKE ?", "%#{email}%")
    else
      scope.where("roles LIKE ?", "%#{role}%")
    end
  end
end
