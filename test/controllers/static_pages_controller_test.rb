require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Hodr"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get admin" do
    get admin_path
    assert_response :success
    assert_select "title", "Command Nexus | #{@base_title}"
  end

  test "should get howto" do
    get howto_path
    assert_response :success
    assert_select "title", "How To | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

  test "should get eula" do
    get eula_path
    assert_response :success
    assert_select "title", "EULA | #{@base_title}"
  end

  test "should get android privacy" do
    get android_path
    assert_response :success
    assert_select "title", "Android Privacy | #{@base_title}"
  end
end
