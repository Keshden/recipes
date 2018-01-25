require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefName: "mashrur", email: "mashrur@example.com", password: "password")
  end

  test "invalid login is rejected" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: " ", password: " " } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path #testing flash.now
    assert flash.empty?
  end

  test "Valid login credentials accepted and begin session" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @chef.email, password: @chef.password } }
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end
end
