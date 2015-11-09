class SearchesController < ApplicationController
	include SearchesHelper

	def index
		@search = Search.new
	end

	def create
		@search = Search.new(politician: params[:search][:politician], organization: params[:search][:organization], user_id: current_user.id, year: params[:search][:year])
		total = @search.total_contributions.to_s

		 p "CONTROLLER TOTAL &" * 20
		 p total
		 p "&" * 80

		@total = comma_separate(total)
		@search[:total] = @total

			if request.xhr?
				if @search.save 
					render partial: '_results', object: @search
				else
					redirect_to @search
				end
			else
				render 'index'
			end
	end

	def show
		@search = Search.find(params[:id])
		render 'show'
	end

	def organization
		@search = Search.new(organization: params[:organization_name])
		
		@recipients = @search.find_top_recipients

		render json: @recipients
	end

end
