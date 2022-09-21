# frozen_string_literal: true

module Users
  class CollaboratorCreatedSubscriber < ApplicationSubscriber
    from_queue "core.collaborator_user.new", ack: true
    ROLE = { groups_names: ["collaborator"] }

    ATTRS = {
      email: :email
    }.freeze

    def process
      Rollbar.info("Users::CollaboratorCreatedSubscriber#process", params: permitted_attributes.merge(ROLE))
      ::ValidateUserBeforeRegisterService.for(permitted_attributes.merge(ROLE))
    end
  end
end
