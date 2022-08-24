# frozen_string_literal: true

module Users
  class ClientRequestSubscriber < ApplicationSubscriber
    from_queue "core.client_user.request"
    ROLE = { roles: ["client"] }

    ATTRS = {
      email: :email
    }.freeze

    def process
      params = permitted_attributes.merge(ROLE)
      service = RegisterService.new(params)
      service.create_user
    end
  end
end
