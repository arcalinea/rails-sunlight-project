require 'rubygems'
require 'httparty'
require 'uri'

class Politician < ActiveRecord::Base
	include HTTParty

  API_KEY = "3ece7eea9ca541f8924a1ee53fd174a8"

	def find_politician_id
		politician = self.politician
		api_url = "http://transparencydata.com/api/1.0/entities.json?search=#{politician}&type=politician&apikey=#{API_KEY}"
		encoded = URI.encode(api_url)
		url = URI.parse(encoded)
		results = HTTParty.get(url)

		ids = {}
		results.each do |result|
			ids[result["name"]] = result["id"]
		end

		return ids
	end

	def find_top_donors
		id_hash = find_politician_id

		p id_hash

		donors = []
		# total_amt = []
		id_hash.each do |name, id|
			api_url = "http://transparencydata.com/api/1.0/aggregates/pol/#{id}/contributors.json?cycle=2012&limit=10&apikey=#{API_KEY}"
			encoded = URI.encode(api_url)
			url = URI.parse(encoded)
			results = HTTParty.get(url)
			p "%" * 60
			p results
			p "%" * 60
			if !results.empty?
				results.each do |result|
					donors << result["name"]
					# total_amt << results["total_amount"]
				end
			end
		end
		p donors
		return donors
	end

end
