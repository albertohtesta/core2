# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "localhost:4000", "https://qa-core.nordhen.com", "https://staging-core.nordhen.com", "https://core.nordhen.com", "https://qa-clients.nordhen.com", "https://staging-clients.nordhen.com", "https://clients.nordhen.com", "https://qa-collaborators.nordhen.com", "https://staging-collaborators.nordhen.com", "https://collaborators.nordhen.com", "https://qa-finances.nordhen.com", "https://staging-finances.nordhen.com", "https://finances.nordhen.com"
    resource "*", headers: :any, methods: %i[get post patch put delete]
  end
end
