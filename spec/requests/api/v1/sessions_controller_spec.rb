# frozen_string_literal: true

require "swagger_helper"

describe "Session", type: :request do
  include WebmockHelper

  let(:user) { create(:user) }
  let(:Authorization) { @token }
  let(:id) { user.id }

  before do
    login_as(user)
  end

  path "/api/v1/sessions" do
    post "Creates a session for the given user" do
      tags "Admins Clients Collaborators"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :session_params, in: :body, schema: {
        type: :object,
        session: {
          username: { type: :string },
          password: { type: :string },
        },
        required: [ "username", "password" ]
      }

      response "200", "Token" do
        let(:session_params) { { session: { username: user.name, password: "sample" } } }

        run_test!
      end
    end
  end
end
