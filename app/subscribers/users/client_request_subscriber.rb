# frozen_string_literal: true

module Users
  class ClientRequestSubscriber < ApplicationSubscriber
    from_queue "core.client_user.request"

    ATTRS = {
      uuid: :uid,
      email: :email
    }.freeze

    def process
      Rails.logger.info permitted_attributes
    end
  end
end
