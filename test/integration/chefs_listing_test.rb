require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefName: "mashrur", email: "mashrur@example.com",
                          password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefName: "mashrur1", email: "mashrur1@example.com",
                          password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: "great saute, add oil and vegies", chef: @chef)
    @recipe2 = @chef2.recipes.build(name: "chicken dinner", description: "great chicken dinner")
    @recipe2.save
    @recipe3 = Recipe.create(name: "Good stuff", description: "Make some good food -_^", chef: @chef2)
  end

  test "should get all chefs" do
    get chefs_path
    assert_response :success
  end

  test "should get Chef Listings" do
    get chefs_path
    assert_template 'chefs/index'
  # assert_match @chef.chefName, response.body
  # assert_match @chef2.chefName, response.body
  # assert_match for just the words, assert_select for a link(link_to)
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefName.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefName.capitalize
  end

  test "should delete chef" do
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end

end
