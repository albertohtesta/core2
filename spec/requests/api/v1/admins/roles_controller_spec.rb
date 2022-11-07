# frozen_string_literal: true

require "swagger_helper"

describe "Admins::Roles", type: :request do
  include WebmockHelper

  path "/api/v1/admins/roles" do
    let(:user) { create(:user, roles: ["admin", "collaborator"]) }
    let(:Authorization) { @token }
    let(:id) { user.id }
    let(:role_params) { }

    before do
      login_as(user)
    end

    patch "Updates a user role" do
      tags "Admins"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :role_params, in: :body, schema: {
        type: :object,
        role: {
          email: { type: :string },
          new_role: { type: :string },
          old_role: { type: :string }
        },
        required: [ "email", "new_role", "old_role" ]
      }

      response "200", "user updated" do
        let(:role_params) { { role: { email: user.email, new_role: "client", old_role: "collaborator" } } }

        run_test!
      end

      response "400", "bad request" do
        let(:role_params) { { role: { email: user.email, new_role: "client", old_role: "jaja" } } }

        run_test!
      end
    end
  end
end
