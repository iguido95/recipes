require 'test_helper'

class ChefTest < ActiveSupport::TestCase
	
	def setup
		@chef = Chef.new(chefname: "Bob", email: "bob@mychefs.com")	
	end
	
	test "Chefname must be present" do
		@chef.chefname = ""
		assert_not @chef.valid?
	end
	
	test "Chefname must be at least 2 characters" do
		@chef.chefname = "a"
		assert_not @chef.valid?
	end	
	
	test "Chefname must be less than or equeal to 40 characters" do
		@chef.chefname = "a"*41
		assert_not @chef.valid?
	end
	
	
	test "Email must be present" do
		@chef.email = ""
		assert_not @chef.valid?
	end	
	
	test "Email must be not too long" do
		@chef.email = "a"*101 + "@example.com"
		assert_not @chef.valid?
	end	
	
	test "Email must be unique" do
		dup_chef = @chef.dup #Create a duplicate
		dup_chef.email = @chef.email.upcase
		@chef.save
		assert_not dup_chef.valid?
	end
	
	test "Email validation should accept valid addresses" do
		valid_addresses = ["user@eee.com", "R_TDD-DS@eee.hello.org", "first.last@eee.au", 
											"laura+jou@monk.nl"]
		valid_addresses.each do |valid_address|
			@chef.email = valid_address
			assert @chef.valid?, "#{valid_address.inspect} should be valid"
		end												
		
	end
	
	test "Email validation should reject invalid addresses" do
		invalid_addresses = ["user@example,com", "user_at_eee.org", "user.name@example.",
												"eee@i_am_.com", "foo@eee+aar.com"]
												
		invalid_addresses.each do |invalid_address|
			@chef.email = invalid_address
			assert_not @chef.valid?, "#{invalid_address.inspect} should be invalid"
		end	
	end	
	
		
end