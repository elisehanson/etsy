class SessionsController < ApplicationController

	def new
		render layout: "new"
	end

	def create
		#try to authenticate the user - if they authenticate successfully, an instance of the User model is returned
		@user = User.authenticate(params[:email], params[:password])
		#if an instance is returned and @user is not nil...
		if @user
		#let the user know they've been logged in with a flash message
		flash[:notice] = "You've been logged in."
		#THIS IS THE MOST IMPORTANT PART. Actually log the user in by storing their ID in the session hash with the [:user_id] key!
		session[:user_id] = @user.id
		#then redirect them to the homepage
		redirect_to "/index"
		else
		#whoops, either the user wasn't in the database or their password is incorrect, so let them know, then redirect them back to the log in page
		flash[:alert] = "There was a problem logging you in."
		redirect_to log_in_path
		end
	end


	def destroy
		session[:user_id] = nil
		flash[:notice] = "You've been logged out successfully."
		redirect_to "/log-in"
	end

end
