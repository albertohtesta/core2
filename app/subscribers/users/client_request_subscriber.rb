# frozen_string_literal: true

module Users
  class ClientRequestSubscriber < ApplicationSubscriber
    from_queue "clients.client_user.request", ack: true
    ROLE = { roles: "client" }

    ATTRS = {
      email: :email
    }.freeze

    def process
      user = UserRepository.find_by_email(permitted_attributes[:email])

      if user
        service = UserService.new({ email: user.email })
        service.enable_user
      else
        params = { email: permitted_attributes[:email] }.merge(ROLE)
        service = RegistrationService.new(params)
        service.create_user
      end
    end
  end
end
