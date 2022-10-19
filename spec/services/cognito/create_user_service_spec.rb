# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cognito::CreateUserService do
  let(:email) { "sample@gmail.com" }
  let(:role) { "collaborator" }
  subject(:service) { described_class.call(email:, role:) }

  context "with valid data" do
    it { expect(service).to be_a_success }
  end

  context "with invalid data" do
    let(:email) { nil }

    it { expect(service).to be_a_failure }
  end
end
