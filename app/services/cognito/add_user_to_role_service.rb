# frozen_string_literal: true

module Cognito
  class AddUserToRoleService
    include ::Integrations::Cognito
    include Interactor

    before :validate_arguments

    def call
      add_user_to_role(email: context.email, role: context.role)
    rescue Aws::CognitoIdentityProvider::Errors::ServiceError => e
      context.fail!(error: e.message)
      Rollbar.error("Cognito::AddUserToRole#call", email: context.email, role: context.role, error: e)
    end

    private

    def validate_arguments
      context.fail!(error: "The given email is invalid") unless context.email
      context.fail!(error: "The given role is not supported") unless ::User::ROLES.include?(context.role)
    end
  end
end
