# frozen_string_literal: true

module Users
  class ClientRequestSubscriber < ApplicationSubscriber
    from_queue "core.client_user.new", ack: true
    ROLE = { groups_names: ["client"] }

    ATTRS = {
      email: :email
    }.freeze

    def process
      Rollbar.info("Users::ClientRequestSubscriber#process", params: permitted_attributes.merge(ROLE))
      ::ValidateUserBeforeRegisterService.for(permitted_attributes.merge(ROLE))
    end
  end
end
