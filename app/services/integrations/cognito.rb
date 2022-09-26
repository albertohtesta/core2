# frozen_string_literal: true

module Integrations
  module Cognito
    CLIENT_ID = ENV.fetch("AWS_COGNITO_USER_POOL_CLIENT_ID", "local").freeze
    POOL_ID = ENV.fetch("AWS_COGNITO_USER_POOL", "local").freeze

    def client
      @client ||= Aws::CognitoIdentityProvider::Client.new(
        region: ENV.fetch("AWS_REGION", "local"),
        access_key_id: ENV.fetch("COGNITO_ADMIN_ACCESS_KEY", "local"),
        secret_access_key: ENV.fetch("COGNITO_ADMIN_SECRET_KEY", "local"),
        stub_responses: Rails.env.test?
      )
    end

    def enable_user(email)
      client.admin_enable_user(
        user_pool_id: POOL_ID,
        username: email
      )
    end

    def disable_user(email)
      client.admin_disable_user(
        user_pool_id: POOL_ID,
        username: email
      )
    end
  end
end
