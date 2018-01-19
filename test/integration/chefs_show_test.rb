require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefName: "mashrur", email: "mashrur@example.com",
                          password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: "great saute, add oil and vegies", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "chicken dinner", description: "great chicken dinner")
    @recipe2.save
  end

  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefName, response.body
  end
end
