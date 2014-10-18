#require all files
require "gisbn/version"
require 'rubygems'
require 'open-uri'
require 'json'

module Gisbn

  class Book
    BASE_URL = 'https://www.googleapis.com/books/v1/volumes?q=isbn:'

    def initialize(number  = nil,
                   key     = 'AIzaSyDKepjfaVBRcgsnPALw5s2UNyfOk-1FHUU',
                   country = 'ca')

      @base_url = BASE_URL + "#{number}&key=#{key}&country=#{country}"
    end
  end
end
