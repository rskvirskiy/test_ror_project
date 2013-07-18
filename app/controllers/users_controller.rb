class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update, :followers, :following]
	before_filter :correct_user,  only: [:edit, :update]
	before_filter :admin_user, only: :destroy

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
		gon.latitude = @user.latitude
		gon.longitude = @user.longitude
		gon.description = @user.fullname.to_s
	end

	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.followed_users.paginate(page: params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])		
	end

	def update
		if @user.update_attributes(params[:user])
			# successful update
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_url
	end

	private

		def parsed_text(user)
			@parsed = user.microposts

		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end	

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

end

