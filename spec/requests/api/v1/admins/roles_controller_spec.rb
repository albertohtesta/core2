# frozen_string_literal: true

require "swagger_helper"

describe "Admins::Roles", type: :request do
  include WebmockHelper

  path "/api/v1/admins/roles" do
    let(:user) { create(:user) }
    let(:Authorization) { @token }
    let(:id) { user.id }

    before do
      login_as(user)
    end

    patch "Updates a user role" do
      tags "Admins"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :user_params, in: :body, schema: {
        type: :object,
        role: {
          email: { type: :string },
          groups_names: { type: :array }
        },
        required: [ "email", "groups_names" ]
      }

      response "200", "user updated" do
        let(:user_params) { { role: { email: user.email, groups_names: ["collaborator"] } } }

        run_test!
      end

      response "400", "bad request" do
        let(:user_params) { { role: { email: "foo" } } }

        run_test!
      end
    end
  end
end
