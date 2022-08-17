# frozen_string_literal: true

module Users
  class CollaboratorCreatedPublisher < ApplicationPublisher
    direct_to "core.collaborator_user.created"
  end
end
