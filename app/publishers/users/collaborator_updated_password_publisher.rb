# frozen_string_literal: true

module Users
  class CollaboratorEnrolledPublisher < ApplicationPublisher
    direct_to "core.collaborator_user.enrolled"

    SCHEMA = {
      uuid: [String]
    }.freeze
  end
end
