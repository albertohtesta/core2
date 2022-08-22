# frozen_string_literal: true

module Users
  class ClientUpdatedSubscriber < ApplicationSubscriber
    from_queue "core.client_user.updated"

    ATTRS = {
      uid: :uid,
      email: :email
    }.freeze

    def process
      Rails.logger.info permitted_attributes.inspect
    end
  end
end
