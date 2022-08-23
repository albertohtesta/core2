# frozen_string_literal: true

require "swagger_helper"

describe "ForgotPassword", type: :request do
  include WebmockHelper

  path "/api/v1/forgot_passwords" do
    let(:user) { create(:user) }
    let(:Authorization) { @token }
    let(:id) { user.id }

    before do
      login_as(user)
    end

    post "Password Recovery for any user" do
      tags "Admins Clients Collaborators"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :recover_password_params, in: :body, schema: {
        type: :object,
        credentials: {
          username: { type: :string },
        },
        required: [ "username" ]
      }

      response "200", "Password recovery email sent" do
        let(:recover_password_params) { { credentials: { username: user.name } } }

        run_test!
      end
    end
  end
end
