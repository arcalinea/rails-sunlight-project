class PoliticiansController < ApplicationController

	def index
		
	end

	def create
		@politician = Politician.new(name: params[:politician][:name])
		@politician[:sunlight_id] = find_politician_id
		p @politician
	end
end
