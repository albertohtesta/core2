# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cognito::CreateUserService do
  let(:email) { "sample@gmail.com" }
  subject(:service) { described_class.call(email:) }

  context "with valid email" do
    it { expect(service).to be_a_success }
  end

  context "with invalid email" do
    let(:email) { nil }

    it { expect(service).to be_a_failure }
  end
end
