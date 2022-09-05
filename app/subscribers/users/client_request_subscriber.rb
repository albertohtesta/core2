# frozen_string_literal: true

module Users
  class ClientRequestSubscriber < ApplicationSubscriber
    from_queue "core.client_user.new", ack: true
    ROLE = { groups_names: ["client"] }

    ATTRS = {
      email: :email
    }.freeze

    def process
      ValidateUserBeforeRegisterService.for(
        { email: permitted_attributes[:email] }.merge(ROLE)
      )
    end
  end
end
