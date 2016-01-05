require 'rubygems'
require 'httparty'
require 'uri'

class Organization < ActiveRecord::Base
	include HTTParty

  def escape_ampersand(name)
    name.gsub(/&/, '%26')
  end


end
