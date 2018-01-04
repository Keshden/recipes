require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefName: "mashrur", email: "mashrur@example.com")
    @recipe = Recipe.create(name: "vegetable saute", description: "great saute, add oil and vegies", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "chicken dinner", description: "great chicken dinner")
    @recipe2.save
  end

  test "Should get recipes index" do
    get recipes_url
    assert_response :success
  end

  test "Should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end


#  test "Should get new recipes form" do
#    get new_recipe_path
#    assert_response :success
#  end

end
