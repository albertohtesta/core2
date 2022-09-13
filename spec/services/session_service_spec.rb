# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionService do
  let(:user) { create(:user, roles: ["admin"]) }
  let(:user_object) do
    {
      username: user.email,
      password: "Password123!"
    }
  end
  let(:role) { user.roles.first }
  subject(:service) { described_class.new(user_object, role) }

  context "with valid params" do
    it "should return an access token" do
      auth_token = service.authenticate

      expect(auth_token).to be_a_kind_of(Hash)
    end

    before do
      login_as(user)
    end

    context "performing a logging out" do
      let(:user_object) { { access_token: @token } }
      let(:role) { "admin" }

      it "should log out" do
        expect(service.sign_out).to eq(true)
      end
    end
  end
end
