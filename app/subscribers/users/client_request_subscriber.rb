# frozen_string_literal: true

module Users
  class ClientRequestSubscriber < ApplicationSubscriber
    from_queue "core.client_user.request"
    ROLE = { roles: ["client"] }

    ATTRS = {
      email: :email
    }.freeze

    def process
      user = User.find_by(email: permitted_attributes[:email])

      if user
        params = { email: user.email, is_enabled: true }
        service = UserService.new(params)
        service.enable_user
      else
        params = { email: permitted_attributes[:email] }.merge(ROLE)
        service = RegistrationService.new(params)
        service.create_user
      end
    end
  end
end
