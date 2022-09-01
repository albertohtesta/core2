# frozen_string_literal: true

# respond to
class ValidateUserBeforeRegisterService < ApplicationService
  attr_reader :payload

  def initialize(payload:)
    @payload = payload
  end

  def process
    service = RegistrationService.new(payload)
    service.create_user
  end

  def valid?
    publish_error("This user #{payload[:email]} already was invited") if find_user
    publish_error("The user #{payload[:email]} already have this #{payload[:role]} role") if role_already_taken?
  end

  private

  def publish_error(message)
    Users::ClientCreatedPublisher.publish(message)
  end

  def find_user
    UserRepository.find_by_email(payload[:email])
  end

  def role_already_taken?
    find_user.roles.include?(payload[:groups_names])
  end
end
