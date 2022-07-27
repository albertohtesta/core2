# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "info", type: :request do
  describe "Info" do
    path "/build-info" do
      get "gets the build info" do
        tags "Info"
        produces "application/json"

        response "200", "info received" do
          schema "$ref" => "#/components/schemas/info"
          run_test!
        end
      end
    end
  end
end
