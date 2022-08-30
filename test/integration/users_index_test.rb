require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users :paul
    @other_user = users :archer
  end
  
  test 'index includes pagination and delete links' do
    log_in_as @admin
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    first_users_page = User.paginate(page: 1)
    first_users_page.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin 
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path @other_user
      assert_response :see_other
      assert_redirected_to users_url
    end
  end

  test 'index as non-admin' do
    log_in_as @other_user
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
