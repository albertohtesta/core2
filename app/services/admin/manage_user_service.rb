# frozen_string_literal: true

module Admin
  class ManageUserService
    include Interactor
    include Integrations::Cognito

    before :valid?

    def call
      enable_disable_user
      context.user = user
    end

    private

    def valid?
      context.fail!(error: "The given user was not found") unless user
    end

    def enable_disable_user
      user.lock!
      user.toggle!(:is_enabled)
      manage_user_from_cognito
    rescue ActiveRecord::ActiveRecordError => e
      context.fail!(error: e)
      Rollbar.error("Admin::ManageUserService::Error", error: e, user:)
    end

    def manage_user_from_cognito
      user.is_enabled? ? enable_user(user.email) : disable_user(user.email)
    rescue Aws::CognitoIdentity::Errors::ServiceError => e
      context.fail!(error: e)
      Rollbar.error("Admin::ManageUserService::Error", error: e, user:)
    end

    def user
      @user ||= User.find_by(id: context.user_id)
    end
  end
end
