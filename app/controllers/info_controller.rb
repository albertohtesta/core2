# frozen_string_literal: true

# endpoint to response with json body to set deployed commit info
class InfoController < ApplicationController
  def build_info
    @info_response = {
      build_id: "#BUILD_ID#",
      build_date: "#BUILD_DATE#",
      build_branch: "#BUILD_BRANCH#"
    }

    render json: @info_response
  end
end
