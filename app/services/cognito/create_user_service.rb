# frozen_string_literal: true

module Cognito
  class CreateUserService
    include ::Integrations::Cognito
    include Interactor

    before :validate_email

    def call
      context.user_created = create_user(email: context.email)
    rescue Aws::CognitoIdentityProvider::Errors::ServiceError => e
      context.fail!(error: e.message)
      Rollbar.error("Cognito::CreateUser#call", email: context.email, error: e)
    end

    private

    def validate_email
      context.fail!(error: "You must pass a valid email") unless context.email
    end
  end
end