class CommentsController < ApplicationController
	before_filter :signed_in_user, only: [:create,:destroy]
	before_filter :correct_user, only: :destroy

	def create
	end

	def destroy
	end

	private
		def correct_user
		end

end