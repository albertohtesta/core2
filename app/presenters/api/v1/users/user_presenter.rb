# frozen_string_literal: true

module Api
  module V1
    module Users
      # presenter for user model
      class UserPresenter < ApplicationPresenter
        ATTRS = %i[email name role].freeze

        def self.paginate_collection(object)
          {
            collection: hash_collection(object),
            pagination: {
              current_page: object.current_page,
              next_page: object.next_page,
              previous_page: object.prev_page,
              total_pages: object.total_pages,
              total_records: object.total_count
            }
          }
        end
      end
    end
  end
end
