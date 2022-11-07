# frozen_string_literal: true

# respond to
class SetPasswordService
  include ::Integrations::Cognito
  include Interactor

  delegate :username, :password, :new_password, to: :context

  before :validate_user
  before :login_temporally

  def call
    set_new_password
    Users::CollaboratorCreatedPublisher.publish(user.attributes)
  end

  private

  def login_temporally
    context.login = login_as_user(username:, password:)
  rescue Aws::CognitoIdentityProvider::Errors::ServiceError => e
    Rollbar.error("SetPasswordService#login_temporally", username: username, error: e)
    context.fail!(error: e.message)
  end

  def set_new_password
    set_new_password_for_user(
      challenge_name: context.login.challenge_name,
      session: context.login.session,
      username:,
      new_password:
    )
  rescue Aws::CognitoIdentityProvider::Errors::ServiceError => e
    Rollbar.error("SetPasswordService#set_new_password", username: username, error: e)
    context.fail!(error: e.message)
  end

  def user
    @user ||= UserRepository.find_by_email(username)
  end

  def validate_user
    context.fail!(error: "The given was not found") unless user
  end
end
