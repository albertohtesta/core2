# frozen_string_literal: true

require "rails_helper"

RSpec.describe ValidateUserBeforeRegisterService do
  let(:payload) do
    {
      email:,
      role:
    }
  end
  let(:role) { "collaborator" }
  let(:email) { "sample@gmail.com" }
  subject(:service) { described_class.call(payload) }

  context "with valid params" do
    it "should register as collaborator user" do
      expect(service).to be_a_success
      expect(User.count).to eq(1)
    end
  end

  context "with an existing user client and inviting him as a client" do
    let(:user) { create(:user, roles: ["client"]) }
    let(:email) { user.email }
    let(:role) { "client" }

    it "should publish a failed message" do
      service

      expect(user.roles.size).to eq(1)
    end
  end

  context "with an existing user client, he will be a collaborator as well" do
    let(:user) { create(:user, roles: ["client"]) }
    let(:email) { user.email }
    let(:role) { "collaborator" }

    it "should save two roles" do
      service
      user.reload
      expect(user.roles.size).to eq(2)
    end
  end
end
