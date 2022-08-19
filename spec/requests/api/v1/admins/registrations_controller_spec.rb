# frozen_string_literal: true

require "swagger_helper"

describe "Admins::Registrations", type: :request do
  include WebmockHelper

  path "/api/v1/admins/registrations" do
    let(:user) { create(:user) }
    let(:Authorization) { @token }
    let(:id) { user.id }

    before do
      login_as(user)
    end

    post "Register a new user" do
      tags "Admins"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :registration_params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          groups_names: { type: :array }
        },
        required: [ "email", "groups_names" ]
      }

      context "register a user with multiples roles" do
        response "200", "Invitation sent successfully" do
          let(:registration_params) { { registration: { email: "panchito@gmail.com", groups_names: ["admin", "collaborator"] } } }

          run_test!
        end
      end

      context "register a user with invalid roles" do
        response "400", "Validation failed: Roles is not included in the list" do
          let(:registration_params) { { registration: { email: "johndoe@gmail.com", groups_names: ["finances", "hr"] } } }

          run_test!
        end
      end
    end
  end
end
