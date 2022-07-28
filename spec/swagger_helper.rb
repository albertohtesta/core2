# frozen_string_literal: true

require "rails_helper"
require Rails.root.join("spec/support/swagger/build_schemas.rb")

RSpec.configure do |config|
  config.swagger_root = Rails.root.join("swagger").to_s
  config.swagger_docs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "Core API V1",
        version: "v1"
      },
      paths: {},
      servers: [
        { url: "https://qa-core-api.nordhen.com" },
        { url: "http://localhost:3000" }
      ],
      components: {
        securitySchemes: {
          Bearer: {
            description: "JWT key necessary to use API calls",
            type: :apiKey,
            name: "Authorization",
            in: :header
          }
        },
        schemas: Swagger::BuildSchemas.to_h
      }
    }
  }

  config.swagger_format = :yaml
end
