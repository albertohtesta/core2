# frozen_string_literal: true

# respond to
class ValidateUserBeforeRegisterService < ApplicationService
  attr_reader :payload

  def initialize(payload:)
    @payload = payload
  end

  def perform
    service = RegistrationService.new(payload)
    service.create_user
  end

  def valid?
    add_error("This user already was invited") if find_user
    add_error("This use already has this role") if role_already_taken?
  end

  private

  def find_user
    UserRepository.find_by_email(payload[:email])
  end

  def role_already_taken?
    find_user.roles.include?(payload[:groups_names])
  end
end
