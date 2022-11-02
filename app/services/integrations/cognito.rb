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

    def create_user(email:, role:)
      client.admin_create_user(
        user_pool_id: POOL_ID,
        username: email,
        desired_delivery_mediums: ["EMAIL"],
        user_attributes: [{ name: "email", value: email }, { name: "email_verified", value: "true" }],
        client_metadata: { "role": role }
      )
    end

    def delete_user(email:)
      client.admin_delete_user(
        user_pool_id: POOL_ID,
        username: email
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

    def add_user_to_role(email:, role:)
      client.admin_add_user_to_group(
        user_pool_id: POOL_ID,
        username: email,
        group_name: role
      )
    end

    def remove_user_from_role(email:, role:)
      client.admin_remove_user_from_group(
        user_pool_id: POOL_ID,
        username: email,
        group_name: role
      )
    end

    def get_user(email:)
      client.admin_get_user(
        user_pool_id: POOL_ID,
        username: email
      )
    end

    def set_password(email:, password:)
      client.admin_set_user_password(
        user_pool_id: POOL_ID,
        username: email,
        password:,
        permanent: true,
      )
    end

    def list_roles_for_user(email:)
      client.admin_list_groups_for_user(
        user_pool_id: POOL_ID,
        username: email
      )
    end

    def login_as_user(username:, password:)
      client.initiate_auth(
        client_id: CLIENT_ID,
        auth_flow: "USER_PASSWORD_AUTH",
        auth_parameters: { USERNAME: username, PASSWORD: password }
      )
    end

    def set_new_password_for_user(challenge_name:, session:, username:, new_password:)
      client.respond_to_auth_challenge(
        client_id: CLIENT_ID,
        challenge_name:,
        session:,
        challenge_responses: { USERNAME: username, NEW_PASSWORD: new_password }
      )
    end
  end
end
