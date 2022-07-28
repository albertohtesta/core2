# frozen_string_literal: true

Rswag::Ui.configure do |c|
  c.swagger_endpoint "v1/swagger.yaml", "API V1 Docs"

  # c.basic_auth_enabled = true
  # c.basic_auth_credentials 'username', 'password'
end
