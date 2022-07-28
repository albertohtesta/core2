# frozen_string_literal: true

module Swagger
  class BuildSchemas
    FOLDER = "spec/fixtures/files/schemas/"
    def self.to_h
      schemas.each_with_object({}).each do |schema_path, hash|
        schema_name = schema_path.split("/").last.gsub(".json", "")
        hash[schema_name] = hashed_schema(schema_path)
      end
    end

    private

    def self.schemas
      Dir.glob(Rails.root.join(FOLDER).join("*.json"))
    end

    def self.hashed_schema(file_path)
      JSON.parse(File.read(file_path))
    end
  end
end
