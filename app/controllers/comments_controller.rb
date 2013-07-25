class CommentsController < ApplicationController
	before_filter :signed_in_user, only: [:create,:destroy]
	before_filter :correct_user, only: :destroy

	def create
		@comment = Micropost.find(params[:comment][:micropost_id]).comments.create(params[:comment])
		if @comment.save
			flash[:success] = "Comment created!"
			redirect_to @comment.micropost.user
		end
	end

	def destroy
		user = Comment.find(params[:id]).micropost.user
		Comment.find(params[:id]).destroy
		redirect_to user
	end

	private
		def correct_user
		end

end