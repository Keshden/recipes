require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefName: "mashrur", email: "mashrur@example.com",
                          password: "password", password_confirmation: "password")
  end

  test "reject invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefName: " ", email: "mashrur@example.com"} }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "Accept valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    patch chef_path, params: {chef: {chefName: "mashrur1", email: "mashrur1@example.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "mashrur1", @chef.chefName
    assert_match "mashrur1@example.com", @chef.email
  end
end
