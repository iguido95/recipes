class ChefsController < ApplicationController

	before_action :set_chef, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update]

	def index
		@chefs = Chef.all.paginate(page: params[:page], per_page: 2)
	end	

	def new 
		@chef = Chef.new
	end	

	def create
		@chef = Chef.new(chef_params)
		if @chef.save
			flash[:success] = "Your account has been created successfully"
			session[:chef_id] = @chef.id
			redirect_to recipes_path
		else
			render 'new'
		end	
	end
	
	def edit
	end
	
	def update
		if @chef.update(chef_params)
			flash[:success] = "Your profile has been updated!"
			redirect_to chef_path(@chef)
		else
			render 'edit'
		end	
	end
	
	def show
		@chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 1)
	end	
	
	
	private 
		def chef_params
			params.require(:chef).permit(:chefname, :email, :password)
		end	

		def require_same_user
			unless logged_in? && @chef == current_user
				flash[:danger] = "You have to be logged in to edit your profile"
				redirect_to root_path
			end
		end

		def set_chef
			@chef = Chef.find(params[:id])
		end	

	
end
	