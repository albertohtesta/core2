# frozen_string_literal: true

module Users
  class ClientCreatedPublisher < ApplicationPublisher
    direct_to "core.client_user.created"
  end
end
