# frozen_string_literal: true

module Users
  class CollaboratorCreatedSubscriber < ApplicationSubscriber
    from_queue "core.collaborator_user.new", ack: true
    ROLE = { role: "collaborator" }

    ATTRS = {
      email: :email
    }.freeze

    def process
      collaborator_params = permitted_attributes.merge(ROLE)
      puts("INVITATION from collaborators: #{collaborator_params}")

      ::Rollbar.info("Users::CollaboratorCreatedSubscriber#process", params: collaborator_params)
      ::ValidateUserBeforeRegisterService.call(collaborator_params)
    end
  end
end
