# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::ManageUserService do
  let(:user) { create(:user, roles: ["client"]) }
  let(:user_id) { user.id }
  subject(:service) { described_class.call(user_id:) }

  context "when we are disabling the user" do
    it { expect(service).to be_a_success }
    it { expect(service.user.is_enabled).to eq(false) }
  end

  context "when we are enabling the user" do
    let(:user_id) { create(:user, is_enabled: false).id }

    it { expect(service).to be_a_success }
    it { expect(service.user.is_enabled).to eq(true) }
  end

  context "with invalid params" do
    let(:user_id) { 234343 }

    it { expect(service).to be_a_failure }
    it "should return an error message" do
      expect(service.error).to match("The given user was not found")
    end
  end
end
