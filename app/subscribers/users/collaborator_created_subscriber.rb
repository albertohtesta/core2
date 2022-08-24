# frozen_string_literal: true

module Users
  class CollaboratorCreatedSubscriber < ApplicationSubscriber
    from_queue "core.collaborator_user.created"

    ATTRS = {
      email: :email
    }.freeze

    def process
      Rails.logger.info permitted_attributes.inspect
    end
  end
end
