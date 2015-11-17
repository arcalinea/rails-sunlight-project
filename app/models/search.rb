require 'rubygems'
require 'httparty'
require 'uri'
# require '/sunlight-project-rails/.env'

class Search < ActiveRecord::Base
	include HTTParty

	base_uri "http://transparencydata.com/api/1.0"

  belongs_to :user

  def search_years(year)
  	year.to_i
	  current_cycle = 2015 + 1
	  all_years = []
	  until year >= current_cycle
	    all_years << year
	    year += 1
	  end
	  all_years.reverse.join("|")
	end

	def escape_ampersand(name)
    name.gsub(/&/, '%26')
  end

	def total_contributions
	  	politician = self.politician
	  	organization = escape_ampersand(self.organization)
	  	years = search_years(self.year)

		# url = "/contributions.json"
		# query = { "amount" => "3E|500", "cycle" => years, "for_against" => "for", ":organization_ft" => organization, "recipient_ft" => politician, "apikey" => ENV['API_KEY']}
		# contributions = self.class.get(url, :query => query)

		api_url = "http://transparencydata.com/api/1.0/contributions.json?amount=%3E|500&cycle=#{years}&for_against=for&organization_ft=#{organization}&recipient_ft=#{politician}&apikey=#{ENV['API_KEY']}"
		encoded = URI.encode(api_url)
		url = URI.parse(encoded)
		contributions = HTTParty.get(url)

		donations = []
		contributions.each do |result|
			donations << result["amount"].to_i
		end

		total = donations.inject(:+)
		return total
	end

	def total=(total)
		@total = total
	end

	def find_org_id
		organization = escape_ampersand(self.organization)
		api_url = "http://transparencydata.com/api/1.0/entities.json?search=#{organization}&type=organization&apikey=#{API_KEY}"
		encoded = URI.encode(api_url)
		url = URI.parse(encoded)
		results = HTTParty.get(url)

		totals = []
		ids = []
		results.each do |result|
			ids << result["id"]
			totals << result["total_given"].to_i
		end

		p "=" * 100
		p ids
		p totals
		p totals.inject(:+)
		p "=" * 100

		return ids
	end

	# def find_top_recipients
	# 	id_array = find_org_id

	# 	recipients = []
	# 	id_array.each do |id|
	# 		api_url = "http://transparencydata.com/api/1.0/aggregates/org/#{id}/recipients.json?cycle=2012&limit=10&apikey=#{ENV['API_KEY']}"
	# 		encoded = URI.encode(api_url)
	# 		url = URI.parse(encoded)
	# 		results = get(url)
	# 		# p "%" * 60
	# 		# p results
	# 		# p "%" * 60
	# 		if !results.empty?
	# 			results.each do |result|
	# 				recipients << result["name"]
	# 			end
	# 		end
	# 	end

	# 	return recipients
	# end

	def find_org_id
		organization = escape_ampersand(self.organization)
		api_url = "/entities.json?search=#{organization}&type=organization&apikey=#{ENV['API_KEY']}"
		encoded = URI.encode(api_url)
		url = URI.parse(encoded)
		results = HTTParty.get(url)

		totals = []
		ids = []
		results.each do |result|
			ids << result["id"]
			totals << result["total_given"].to_i
		end

		p "=" * 100
		p ids
		p totals
		p totals.inject(:+)
		p "=" * 100

		return ids
	end


	def find_top_recipients
		id_array = find_org_id

		p id_array

		recipients = []
		id_array.each do |id|
			url = "/aggregates/org/#{id}/recipients.json"
			
			query   = { "cycle" => "2012", "limit" => 10, "apikey" => ENV['API_KEY']}

			results = self.class.get(url, :query => query)

			if !results.empty?
				results.each do |result|
					recipients << result["name"]
				end
			end
		end

		return recipients
	end

end
