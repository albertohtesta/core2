# frozen_string_literal: true

# create cognito user
class RegistrationService < CognitoService
  attr_reader :error

  def create_user
    ActiveRecord::Base.transaction do
      User.create!(email: @user_object[:email], roles: @user_object[:groups_names])
    rescue StandardError => e
      Rollbar.error("RegistrationService#create_user Error", error: e, params: @user_object)
      @error = e
      return false
    end

    begin
      resp = CognitoService::CLIENT.admin_create_user(auth_object)
      Rollbar.info("RegistrationService", cognito_response: resp)
      add_user_to_table(resp)
      publish_created_user
      AddUserToAwsCognitoPoolGroupJob.perform_later(@user_object)
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def publish_created_user
    Rollbar.info("RegistrationService Publisher", user:)
    Users::CollaboratorCreatedPublisher.publish(user.attributes) if user.roles.include?("collaborator")
    Users::ClientCreatedPublisher.publish(user.attributes) if user.roles.include?("client")
  end

  def user
    ActiveRecord::Base.transaction do
      @user ||= User.find_by!(email: @user_object[:email])
    end
  end

  def add_user_to_table(response)
    user.lock!
    user.update!(uuid: response.user.username)
  end

  def auth_object
    {
      user_pool_id: CognitoService::POOL_ID,
      username: @user_object[:email],
      desired_delivery_mediums: ["EMAIL"],
      user_attributes: [{ name: "email", value: @user_object[:email] }, { name: "email_verified", value: "true" }]
    }
  end
end
