# frozen_string_literal: true

class RegisterUserService
  include Interactor

  before :validate_email_and_role

  def call
    ActiveRecord::Base.transaction do
      context.user = User.create!(email: context.email, roles: [context.role], uuid: context.uuid)
    rescue ActiveRecord::ActiveRecordError => e
      context.fail!(error: e.message)
      Rollbar.error("RegisterUserService#call Error", email: context.email, role: context.role, error: e)
    end
  end

  private

  def validate_email_and_role
    context.fail!(error: "You must provide an email") unless context.email
    context.fail!(error: "You must provide a role") unless context.role
    context.fail!(error: "You must provide a uuid") unless context.uuid
  end
end
