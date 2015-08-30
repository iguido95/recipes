class RecipesController < ApplicationController 
	
	def index
		@recipes = Recipe.paginate(page: params[:page], :per_page => 3).order('created_at DESC')
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
	
	def edit
		@recipe = Recipe.find(params[:id])
	end
	
	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update(recipe_params)
			flash[:success] = "Your recipe was successfully updated!"
			redirect_to recipe_path(params[:id])
		else
			render :edit
		end				
	end	
	
	def like
		@recipe = Recipe.find(params[:id])
		@like = Like.create(like: params[:like], chef: Chef.last, recipe: @recipe)
		if @like.valid?
			flash[:success] = "Your like/dislike was successful"
		else 
			flash[:danger] = "You can only like once!"
		end	
		redirect_to :back
	end	
	
	
	private
		def recipe_params 
			params.require(:recipe).permit(:name, :summary, :description, :picture)
		end	
	
end	