# frozen_string_literal: true

require "swagger_helper"

describe "Admins::Users", type: :request do
  include WebmockHelper

  let(:user) { create(:user) }
  let(:Authorization) { @token }
  let(:id) { user.id }

  before do
    login_as(user)
  end

  path "/api/v1/admins/users" do
    get "List all users" do
      tags "Admins"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :user_params, in: :body, schema: {
        "$ref" => "#/components/schemas/user"
      }

      response "200", "user updated" do
        let(:user_params) { { email: user.email, is_enabled: false } }

        run_test!
      end
    end
  end

  path "/api/v1/admins/users/{id}" do
    parameter name: :id, in: :path, type: :integer, description: "id"

    put "Updates a user" do
      tags "Admins"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :user_params, in: :body, schema: {
        "$ref" => "#/components/schemas/user"
      }

      response "200", "user updated" do
        let(:user_params) { { email: user.email, is_enabled: false } }

        run_test!
      end

      response "422", "unprocessable entity" do
        let(:user_params) { { email: "foo" } }

        run_test!
      end
    end
  end
end
