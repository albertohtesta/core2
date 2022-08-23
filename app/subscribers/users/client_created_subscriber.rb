# frozen_string_literal: true

module Users
  class ClientCreatedSubscriber < ApplicationSubscriber
    from_queue "core.client_user.created"

    ATTRS = {
      uid: :uid,
      email: :email
    }.freeze

    def process
      RegistrationService.new(permitted_attributes)
    end
  end
end
