# frozen_string_literal: true

require "test_helper"

class RegistrationServiceTest < ActiveSupport::TestCase
  test "should update password" do
    @password_service = PasswordService.new({password: "Somepassword123!", new_password: "Newpassword123!", access_token: "1z34s6t8g"})
   
    assert(@password_service.update_password)
  end

  test "should not update password without password" do
    @password_service = PasswordService.new({new_password: "Newpassword123!", access_token: "1z34s6t8g"})
    @password_service.update_password
    
    assert_equal("missing required parameter params[:previous_password]", @password_service.error.message)
  end

  test "should not update password without new_password" do
    @password_service = PasswordService.new({password: "Somepassword123!", access_token: "1z34s6t8g"})
    @password_service.update_password
    
    assert_equal("missing required parameter params[:proposed_password]", @password_service.error.message)
  end

  test "should not update password without access_token" do
    @password_service = PasswordService.new({password: "Somepassword123!", new_password: "Newpassword123!"})
    @password_service.update_password
    
    assert_equal("missing required parameter params[:access_token]", @password_service.error.message)
  end

end
