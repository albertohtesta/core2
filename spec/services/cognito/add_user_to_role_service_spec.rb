# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cognito::AddUserToRoleService do
  let(:email) { "sample@gmail.com" }
  let(:role) { "collaborator" }
  subject(:service) { described_class.call(email:, role:) }

  context "with valid email" do
    it { expect(service).to be_a_success }
  end

  context "with invalid email" do
    let(:email) { nil }

    it { expect(service).to be_a_failure }
  end

  context "with invalid random role" do
    let(:role) { "foo_role" }

    it { expect(service).to be_a_failure }
  end
end
