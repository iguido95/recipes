class RecipesController < ApplicationController 
	
	def index
		@recipes = Recipe.all.order("created_at DESC")
	end	
	
	def show
		@recipe = Recipe.find(params[:id])
	end	
	
	def new
		@recipe = Recipe.new
	end	
	
	def create 
		@recipe = Recipe.new(recipe_params)
		@recipe.chef = Chef.find(2)
		if @recipe.save
			#When the recipe is succesfully saved
			flash[:success] = "Your recipe has been succesfully created!"
			redirect_to recipes_path
		else
			#render template again, with the @recipe instance variable
			render :new
		end	
	end
	
	
	private
		def recipe_params 
			params.require(:recipe).permit(:name, :summary, :description)
		end	
	
end	