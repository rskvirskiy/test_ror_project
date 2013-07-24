class CommentsController < ApplicationController
	before_filter :signed_in_user, only: [:create,:destroy]
	before_filter :correct_user, only: :destroy

	def create
		@comment = Micropost.find(params[:comment][:micropost_id]).comments.create(content: params[:comment][:content], by: params[:comment][:by])
		if @comment.save
			flash[:success] = "Comment created!"
			redirect_to @comment.micropost.user
		end
	end

	def destroy
	end

	private
		def correct_user
		end

end