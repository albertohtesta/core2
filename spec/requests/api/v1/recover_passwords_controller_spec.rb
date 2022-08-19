# frozen_string_literal: true

require "swagger_helper"

describe "Recover", type: :request do
  include WebmockHelper

  let(:user) { create(:user) }
  let(:Authorization) { @token }
  let(:id) { user.id }

  before do
    login_as(user)
  end

  path "/api/v1/recover_passwords" do
    post "Recover a user password" do
      tags "Admins Clients Collaborators"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :confirm_recover_password_params, in: :body, schema: {
        type: :object,
        credentials: {
          username: { type: :string },
          password: { type: :string },
          confirmation_code: { type: :string },
        },
        required: [ "username", "password", "new_password" ]
      }

      response "200", "Password recovered" do
        let(:confirm_recover_password_params) do
          { credentials: { username: user.name, password: "holis", confirmation_code: "sample password" } }
        end

        run_test!
      end
    end
  end
end
