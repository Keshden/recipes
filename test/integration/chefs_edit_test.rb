require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefName: "mashrur", email: "mashrur@example.com",
                          password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefName: "joseph", email: "joseph@example.com",
                          password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefName: "john", email: "john@example.com",
                          password: "password", password_confirmation: "password", admin: true)
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

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    patch chef_path, params: {chef: {chefName: "mashrur3", email: "mashrur3@example.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "mashrur3", @chef.chefName
    assert_match "mashrur3@example.com", @chef.email
  end

  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params: {chef: {chefName: updated_name, email: updated_email}}
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "mashrur", @chef.chefName
    assert_match "mashrur@example.com", @chef.email
  end
end
