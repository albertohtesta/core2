# frozen_string_literal: true

require "test_helper"

module Api
  module V1
    module Users
      class UserPresenterTest < ActionDispatch::IntegrationTest
        def user
          @user ||= create(:user)
        end

        def paginate_data
          @paginate_data ||= User.page(1).per(1)
        end

        def decorate_user
          @decorate_user ||= UserPresenter.new(@user)
        end

        test "must present user as json" do
          expected_response = {
            name: user.name,
            email: user.email,
            role: "admin"
          }.to_json

          assert_equal expected_response, decorate_user.json
        end

        test "must present paginate object" do
          expected_response = {
            collection: [],
            pagination: {
              current_page: paginate_data.current_page,
              next_page: paginate_data.next_page,
              previous_page: paginate_data.prev_page,
              total_pages: paginate_data.total_pages,
              total_records: User.count
            }
          }

          assert_equal expected_response, UserPresenter.paginate_collection(paginate_data)
        end
      end
    end
  end
end
