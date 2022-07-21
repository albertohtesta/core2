# frozen_string_literal: true

class UserRepositoryTest < ActiveSupport::TestCase
  setup do
    create(:user, email: "btest@email.com")
    create(:user, email: "atest@email.com")
  end

  test "must return users in asc order" do
    assert_equal UserRepository.ordered_by_email.collect(&:email), ["atest@email.com", "btest@email.com"]
  end
end
