# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::ManageUserService do
  let(:user) { create(:user, roles: ["client"]) }
  let(:user_id) { user.id }
  subject(:service) { described_class.call(user_id:) }

  context "with valid params" do
    it "should be success" do
      expect(service.success?).to eq(true)
    end
  end

  context "with invalid params" do
    let(:user_id) { 234343 }

    it "should return be false" do
      expect(service.success?).to eq(false)
      expect(service.error).to match("The given user was not found")
    end
  end
end
