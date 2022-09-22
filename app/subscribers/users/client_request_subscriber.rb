# frozen_string_literal: true

module Users
  class ClientRequestSubscriber < ApplicationSubscriber
    from_queue "core.client_user.new", ack: true
    ROLE = { groups_names: ["client"] }

    ATTRS = {
      email: :email
    }.freeze

    def process
      client_params = permitted_attributes.merge(ROLE)

      ::Rollbar.info("Users::ClientRequestSubscriber#process", params: client_params)
      ::ValidateUserBeforeRegisterService.for(client_params)
    end
  end
end
