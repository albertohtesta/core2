# frozen_string_literal: true

require "rails_helper"

RSpec.describe RegisterUserService do
  let(:email) { "sample@gmail.com" }
  let(:role) { "collaborator" }
  let(:uuid) { "234343ffffdfifdfff" }
  subject(:service) { described_class.call(email:, role:, uuid:) }

  context "with valid data" do
    it { expect(service).to be_a_success }

    it "should be saved" do
      service
      user_created = User.find_by(email:)

      expect(user_created.email).to eq(email)
      expect(User.count).to eq(1)
    end
  end

  context "with invalid random role" do
    let(:role) { "foo_role" }

    it { expect(service).to be_a_failure }
  end
end
