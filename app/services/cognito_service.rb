# frozen_string_literal: true

# create cognito client
class CognitoService < ApplicationService
  CLIENT = Aws::CognitoIdentityProvider::Client.new(
    region: ENV.fetch("AWS_REGION", nil),
    access_key_id: ENV.fetch("ACCESS_KEY_ID", nil),
    secret_access_key: ENV.fetch("SECRET_ACCESS_KEY", nil)
  ).freeze

  def initialize(user_object)
    @user_object = user_object
  end
end
