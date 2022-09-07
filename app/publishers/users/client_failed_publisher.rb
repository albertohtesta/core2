# frozen_string_literal: true

module Users
  class ClientFailedPublisher < ApplicationPublisher
    direct_to "core.client_user.failed"

    SCHEMA = {
      message: [String]
    }.freeze
  end
end
