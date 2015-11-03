require 'rubygems'
require 'httparty'
require 'uri'

class Organization < ActiveRecord::Base
	include HTTParty

  API_KEY = "3ece7eea9ca541f8924a1ee53fd174a8"

  def escape_ampersand(name)
    name.gsub(/&/, '%26')
  end


end
