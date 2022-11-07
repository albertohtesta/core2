# frozen_string_literal: true

require "swagger_helper"

describe "Password", type: :request do
  include WebmockHelper

  let(:user) { create(:user) }
  let(:Authorization) { @token }
  let(:id) { user.id }

  before do
    login_as(user)
  end

  path "/api/v1/passwords" do
    put "Update a user password" do
      tags "Admins Clients Collaborators"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :sessions_params, in: :body, schema: {
        type: :object,
        credentials: {
          username: { type: :string },
          password: { type: :string },
          new_password: { type: :string },
        },
        required: [ "username", "password", "new_password" ]
      }

      response "200", "Password updated" do
        let(:sessions_params) do
          {
            credentials: { username: user.email, password: "sample pass", new_password: "my password" }
          }
        end

        run_test!
      end
    end
  end

  path "/api/v1/passwords" do
    post "Update a user password" do
      tags "Admins Clients Collaborators"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :sessions_params, in: :body, schema: {
        type: :object,
        credentials: {
          username: { type: :string },
          password: { type: :string },
          new_password: { type: :string },
        },
        required: [ "username", "password", "new_password" ]
      }

      response "200", "Password set successfully. A confirmation mail was sent." do
        let(:sessions_params) do
          {
            credentials: { username: user.email, password: "sample pass", new_password: "my password" }
          }
        end

        run_test!
      end
    end
  end
end
