require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
      get signup_path
      assert_no_difference 'User.count' do
        post users_path, params: { user: { uname:  "",
                                           email: "awlove@aubreylove",
                                           password:              "abc",
                                           password_confirmation: "123" } }
      end
      assert_response :unprocessable_entity
      assert_template 'users/new'
    end

    test "valid signup information" do
        assert_difference 'User.count', 1 do
          post users_path, params: { user: { uname:  "TheViking",
                                             email: "awlove@aubreylove.space",
                                             password:              "abc123",
                                             password_confirmation: "abc123" } }
        end
        follow_redirect!
        assert_template 'users/show'
        assert is_logged_in?
      end
end
