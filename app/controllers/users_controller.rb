class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@searches = Search.where(user_id: current_user.id)
		p @searches
	end
end
