# frozen_string_literal: true

require "swagger_helper"

describe "Users", type: :request do
  include WebmockHelper

  path "/api/v1/users/{id}" do
    let(:user) { create(:user) }
    let(:Authorization) { @token }
    let(:id) { user.id }

    before do
      login_as(user)
    end

    parameter name: :id, in: :path, type: :integer, description: "id"

    put "Updates a user" do
      tags "Users"
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
