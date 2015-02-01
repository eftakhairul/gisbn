#require all files
require "gisbn/version"
require 'rubygems'
require 'net/http'
require 'json'


module Gisbn

  class Book

    attr_reader :result, :isbn
    BASE_URL = 'https://www.googleapis.com/books/v1/volumes?q=isbn:'

    # Initialize a new Book object by ISBN (either by ISBN 10 or ISBN 13)
    #
    # At Interactive Ruby Shell...
    # require 'gisbn'
    # book = Gisbn::Book.new "0262033844"
    #
    # book.title #=> "Introduction to Algorithms"
    #
    def initialize(isbn     = nil,
                   key      = 'AIzaSyDKepjfaVBRcgsnPALw5s2UNyfOk-1FHUU',
                   country  = 'ca')


      @isbn     = isbn.strip! || isbn
      response  = Net::HTTP.get_response(URI.parse(BASE_URL + "#{isbn}&key=#{key}&country=#{country}")).body
      @result   = JSON.parse(response)
    end

    #Return the description of the book
    def description
      @result["items"][0]["description"]
    end

    #Return the title of the book
    def title
      @result["items"][0]["volumeInfo"]["title"]
    end

    #Return the all authors' name as comma separated
    def authors
      @result["items"][0]["volumeInfo"]["authors"].join(",")
    end

    #Return the all authors' name as array
    def authors_as_array
      @result["items"][0]["volumeInfo"]["authors"]
    end

    #Return the ten digit ISBN
    def ISBN_10
      @result["items"][0]["industryIdentifiers"][1]["identifier"]
    end

    #Return the thirteen  digit ISBN
    def ISBN_13
      @result["items"][0]["industryIdentifiers"][0]["identifier"]
    end
  end
end
