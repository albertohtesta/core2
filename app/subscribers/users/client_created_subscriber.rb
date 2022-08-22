# frozen_string_literal: true

module Users
  class ClientCreatedSubscriber < ApplicationSubscriber
    from_queue "core.client_user.created"

    ATTRS = {
      uid: :uid,
      email: :email
    }.freeze

    def process
      Rails.logger.info permitted_attributes.inspect
    end
  end
end
