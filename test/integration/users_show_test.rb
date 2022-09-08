# frozen_string_literal: true

require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @inactive_user = users :inactive
    @active_user = users :paul
  end

  test 'should redirect when user not actived' do
    get user_path @inactive_user
    assert_response :found
    assert_redirected_to root_url
  end

  test 'should display user when activated' do
    get user_path @active_user
    assert_response :ok
    assert_template 'users/show'
  end
end
