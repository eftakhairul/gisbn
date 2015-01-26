#require all files
require "gisbn/version"
require 'rubygems'
require 'net/http'
require 'json'


module Gisbn

  class Book
    attr_reader :result, :isbn
    BASE_URL = 'https://www.googleapis.com/books/v1/volumes?q=isbn:'

    def initialize(isbn     = nil,
                   key      = 'AIzaSyDKepjfaVBRcgsnPALw5s2UNyfOk-1FHUU',
                   country  = 'ca')


      @isbn     = isbn
      response = Net::HTTP.get_response(URI.parse(BASE_URL + "#{isbn}&key=#{key}&country=#{country}")).body
      @result = JSON.parse(response)
    end

    def description
      @result["items"]["description"]
    end
  end
end
