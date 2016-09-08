require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path

    # rails-controller-testing required
    # assert_template 'static_pages/home'

    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
  end

  test "full title helper" do
    assert_equal full_title, "(EXE)rcices en (L)angue (F)rançaise"
    assert_equal full_title("Help"), "Help | (EXE)rcices en (L)angue (F)rançaise"    
  end
end
