require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
	
	def setup
		@chef = Chef.create(chefname: "Bob", email: "bob@example.com")
		@recipe = @chef.recipes.build(name: "Cookie baking", summary: "This is a good cooking guide for cookies", 
							description: "Bake the cookies in the oven and then eat the cookies with your mouth")
		#This is a valid recipe
	end	
	
	test "Recipe should be valid" do
		assert @recipe.valid?
	end	
	
	test "Chef association should be present" do
		@recipe.chef_id = nil 
		assert_not @recipe.valid?
	end	
	
	test "Name should be present" do
		@recipe.name = ""
		assert_not  @recipe.valid? #This should be false. Because the name is now not present.
	end
	
	test "Name length at least 5 characters" do
		@recipe.name = "a"*4
		assert_not @recipe.valid?
	end	
	
	test "Name length less than or equal to 100 characters" do
		@recipe.name = "a"*101
		assert_not @recipe.valid?
	end	
	
	test "Summary must be present" do
		@recipe.summary = ""
		assert_not @recipe.valid?
	end
	
	test "Summary length at least 10 characters" do
		@recipe.summary = "a"*9
		assert_not @recipe.valid?
	end
	
	test "Summary length less than or equal to 150 characters" do
		@recipe.summary = "a"*151
		assert_not @recipe.valid?
	end	
	
	test "Description must be present" do
		@recipe.description = ""
		assert_not @recipe.valid?
	end
	
	test "Description length at least 20 characters" do
		@recipe.description = "a"*19
		assert_not @recipe.valid?
	end
	
	test "Description length less than or equal to 500 characters" do
		@recipe.description = "a"*501
		assert_not @recipe.valid?
	end		
	
end	