class RecipesController < ApplicationController 
	before_action :set_recipe, only: [:show, :edit, :update, :like]
	before_action :require_user, except: [:show, :index]
	before_action :require_same_user, only: [:edit, :update]

	def index
		@recipes = Recipe.paginate(page: params[:page], :per_page => 3).order('created_at DESC')
	end	
	
	def show
	end	
	
	def new
		@recipe = Recipe.new
	end	
	
	def create 
		binding.pry
		@recipe = Recipe.new(recipe_params)
		@recipe.chef = current_user
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
		if @recipe.update(recipe_params)
			flash[:success] = "Your recipe was successfully updated!"
			redirect_to recipe_path(params[:id])
		else
			render :edit
		end				
	end	
	
	def like
		@like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
		if @like.valid?
			flash[:success] = "Your like/dislike was successful"
		else 
			flash[:danger] = "You can only like once!"
		end	
		redirect_to :back
	end	
	
	
	private
		def recipe_params 
			params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
		end	

		def set_recipe
			@recipe = Recipe.find(params[:id])
		end
		
		def require_same_user
			unless logged_in? && @recipe.chef == current_user
				flash[:danger] = "You can only edit your own recipes"
				redirect_to root_path
			end	
		end	
	
end	