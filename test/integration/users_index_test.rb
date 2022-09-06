# frozen_string_literal: true

require 'test_helper'

class UsersIndex < ActionDispatch::IntegrationTest
  def setup
    @admin = users :paul
    @other_user = users :archer
  end
end

class UsersIndexAdmin < UsersIndex
  def setup
    super
    log_in_as @admin
    get users_path
  end
end

class UsersIndexAdminTest < UsersIndexAdmin
  test 'should render index page' do
    assert_template 'users/index'
  end

  test 'should paginate users' do
    assert_select 'div.pagination', count: 2
  end

  test 'should have delete links' do
    first_users_page = User.where(activated: true).paginate(page: 1)
    first_users_page.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      assert_select 'a[href=?]', user_path(user), text: 'delete' unless user == @admin
    end
  end

  test 'should be able to delete non-admin user' do
    assert_difference 'User.count', -1 do
      delete user_path @other_user
      assert_response :see_other
      assert_redirected_to users_url
    end
  end

  test 'should display only activated users' do
    User.paginate(page: 1).first.toggle! :activated
    assigns(:users).each do |user|
      assert user.activated?
    end
  end
end

class UsersIndexNonAdminTest < UsersIndex
  test 'index as non-admin' do
    log_in_as @other_user
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
