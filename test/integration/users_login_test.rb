# frozen_string_literal: true

require 'test_helper'

class UsersLogin < ActionDispatch::IntegrationTest
  def setup
    @user = users(:paul)
  end
end

class InvalidPasswordTest < UsersLogin
  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: { session: { email: '', password: '' } }

    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?

    get root_path

    assert flash.empty?
  end
end

class ValidLogin < UsersLogin
  def setup
    super
    post login_path, params: { session: { email: @user.email, password: 'password' } }
  end
end

class ValidLoginTest < ValidLogin
  test 'valid login' do
    assert logged_in?
    assert_redirected_to @user
  end

  test 'gets redirected' do
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end
end

class Logout < ValidLogin
  def setup
    super
    delete logout_path
  end
end

class LogoutTest < Logout
  test 'gets logged out' do
    assert_not logged_in?
    assert_response :see_other
  end

  test 'gets redirected after logout' do
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end

  test 'Logout works when clicking in a second window' do
    follow_redirect!
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
