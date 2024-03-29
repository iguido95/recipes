class LoginsController < ApplicationController

	def new
	end

	def create
		chef = Chef.find_by(email: params[:email])
		if chef && chef.authenticate(params[:password])
			
			session[:chef_id] = chef.id

			flash[:success] = "You are logged in"
			redirect_to recipes_path
		else 
			flash.now[:danger] = "Your email address or password does not match"
			render 'new'
		end

	end

	def destroy
		if session[:chef_id] != nil
			session[:chef_id] = nil
			flash[:success] = "You are logged out"
		else 
			flash[:danger] = "You were already logged out"
		end
		redirect_to root_path
	end
end
