class IngredientsController < ApplicationController

	before_action :require_user, except: [:show]

	def show
		@ingredient = Ingredient.find(params[:id])
		@recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 4)
	end

	def new 
		@ingredient = Ingredient.new
	end

	def create
		@ingredient = Ingredient.new(ingredient_params)

		if @ingredient.save
			flash[:success] = "Ingredient has been created successfully"
			redirect_to new_ingredient_path
		else
			flash[:danger] = "Ingredient has not been created successfully"
			render 'new'
		end
	end

	private
		def ingredient_params
			params.require(:ingredient).permit(:name)
		end

end