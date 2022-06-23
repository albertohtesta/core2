# frozen_string_literal: true

# endpoint to response with json body to set deployed commit info
class InfoController < ApplicationController
  def build_info
    info_response = File.read(Rails.root.join("build-info.json"))
    render json: info_response
  end
end
