require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal 'RecipeMaker', full_title
    assert_equal 'Help | RecipeMaker', full_title("Help")
  end
end
