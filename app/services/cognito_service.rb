# frozen_string_literal: true

# create cognito client
class CognitoService < ApplicationService
  CLIENT = Aws::CognitoIdentityProvider::Client.new(
    region: ENV.fetch("AWS_REGION", nil),
    access_key_id: ENV.fetch("COGNITO_ADMIN_ACCESS_KEY", nil),
    secret_access_key: ENV.fetch("COGNITO_ADMIN_SECRET_KEY", nil),
    stub_responses: Rails.env.test?
  ).freeze

  CLIENT_ID = ENV.fetch("AWS_COGNITO_USER_POOL_CLIENT_ID", nil).freeze
  POOL_ID = ENV.fetch("AWS_COGNITO_USER_POOL", nil).freeze

  def initialize(user_object)
    @user_object = user_object
  end
end
