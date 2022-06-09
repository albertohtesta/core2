# frozen_string_literal: true

class InfoController < ApplicationController
  def build_info
    @info_response = {
      build_id: 'test 1',
      build_date: 'test 2',
      build_branch: 'test 3'
    }

    render json: @info_response
  end
end
