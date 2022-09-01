# frozen_string_literal: true

require "swagger_helper"

describe "Session", type: :request do
  include WebmockHelper

  context "routes for admin" do
    let(:user) { create(:user) }
    let(:Authorization) { @token }
    let(:id) { user.id }

    before do
      login_as(user)
    end

    path "/api/v1/admin/sessions" do
      post "Creates a session for the given user" do
        tags "Admins"
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

  context "routes for client" do
    let(:user) { create(:user, roles: ["client"]) }
    let(:Authorization) { @token }
    let(:id) { user.id }

    before do
      login_as(user)
    end

    path "/api/v1/client/sessions" do
      post "Creates a session for the client user" do
        tags "Clients"
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

  context "with invalid role" do
    let(:user) { create(:user, roles: ["client"]) }
    let(:Authorization) { @token }
    let(:id) { user.id }

    before do
      login_as(user)
    end

    path "/api/v1/fake_role/sessions" do
      post "Creates a session for the client user" do
        tags "Clients"
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

        response "404", "Error" do
          let(:session_params) { { session: { username: user.name, password: "sample" } } }

          run_test!
        end
      end
    end
  end
end
