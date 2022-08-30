# frozen_string_literal: true

module Users
  class CollaboratorCreatedSubscriber < ApplicationSubscriber
    from_queue "core.collaborator_user.created"
    ROLE = { groups_names: ["collaborator"] }

    ATTRS = {
      email: :email
    }.freeze

    def process
      ValidateUserBeforeRegisterService.perform(
        { email: permitted_attributes[:email] }.merge(ROLE)
      )
    end
  end
end
