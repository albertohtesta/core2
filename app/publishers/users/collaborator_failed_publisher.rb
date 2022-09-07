# frozen_string_literal: true

module Users
  class CollaboratorFailedPublisher < ApplicationPublisher
    direct_to "core.collaborator_user.failed"

    SCHEMA = {
      message: [String]
    }.freeze
  end
end
