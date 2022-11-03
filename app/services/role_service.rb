# frozen_string_literal: true

# authenticate cognito user
class RoleService
  include Interactor
  include Integrations::Cognito

  before :valid_role?

  def call
    remove_and_update_with_new_role
    remove_role_from_cognito
    add_role_to_cognito
  end

  private

  def user
    UserRepository.find_by_email(context.email)
  end

  def valid_role?
    context.fail!(error: "This user dont has the given role") unless user.roles.include?(context.old_role)
  end

  def remove_and_update_with_new_role
    ActiveRecord::Base.transaction do
      update_user = user
      update_user.roles.reject { |role| role == context.old_role }
      update_user.roles << context.new_role
      update_user.save!
    rescue ActiveRecord::RecordInvalid => e
      Rollbar.error("RoleService#update_db_role", email: context.email, role: context.old_role, error: e)
      context.fail!(error: e)
    end
  end

  def remove_role_from_cognito
    service = Cognito::RemoveUserRoleService.call(email: context.email, role: context.old_role)
    context.fail!(error: service.error) if service.failed
  end

  def add_role_to_cognito
    service = Cognito::AddUserToRoleService.call(email: context.email, role: context.new_role)
    context.fail!(error: service.error) if service.failed
  end
end
