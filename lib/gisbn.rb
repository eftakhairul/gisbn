#require all files
require "gisbn/version"
require 'rubygems'
require 'open-uri'
require 'json'

module Gisbn

  @base_ur = 'https://www.googleapis.com/books/v1/volumes?key=AIzaSyDKepjfaVBRcgsnPALw5s2UNyfOk-1FHUU&country=bd&q=isbn:'

  def initialize(key, country = nil)
    if !key.nil?
      @base_ur ||= @base_ur + "/key=#{key}"
    end

  end

end
