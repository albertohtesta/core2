# frozen_string_literal: true

module Users
  class ClientRequestSubscriber < ApplicationSubscriber
    from_queue "clients.client_user.request", ack: true
    ROLE = { groups_names: ["client"] }

    ATTRS = {
      email: :email
    }.freeze

    def process
      ValidateUserBeforeRegisterService.for(permitted_attributes.merge(ROLE))
    end
  end
end
