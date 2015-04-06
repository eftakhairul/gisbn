#require all files
require "gisbn/version"
require 'rubygems'
require 'net/http'
require 'json'


module Gisbn

  class Book

    attr_reader :result, :isbn
    BASE_URL = 'https://www.googleapis.com/books/v1/volumes?q=isbn:'

    # Initialize a new Book object by ISBN (either ISBN 10 or ISBN 13)
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

    # Description of the book
    #
    # Example:
    #   >> gisbn.title
    #   => ""
    #
    # Return:
    #     String
    def description
      @result["items"][0]["description"]
    end

    # Title of the book
    # Example:
    #   >> gisbn.title
    #   => "Introduction to Algorithms"
    #
    # Return:
    #     String
    def title
      @result["items"][0]["volumeInfo"]["title"]
    end

    # It returns all authors' name as comma separated string
    #
    # Example:
    #   >> gisbn.authors_as_array
    #   => "harles E. Leiserson, Clifford Stein, Ronald Rivest,Thomas H. Cormen"
    #
    # Return:
    #     String
    def authors
      @result["items"][0]["volumeInfo"]["authors"].join(", ")
    end

    # It returns all authors' name as array
    #
    # Example:
    #   >> gisbn.authors_as_array
    #   => ["harles E. Leiserson", "Clifford Stein", "Ronald Rivest", "Thomas H. Cormen"]
    #
    # Return:
    #     array
    def authors_as_array
      @result["items"][0]["volumeInfo"]["authors"]
    end

    # It returns publisher name
    #
    # Example:
    #   >> gisbn.publisher
    #   => "MIT Press"
    #
    # Return:
    #     String
    def publisher
      @result["items"][0]["volumeInfo"]["publisher"]
    end


    # It returns the ten digit ISBN number of book
    #
    # Example:
    #   >> gisbn.isbn_10
    #   => "0262033844"
    #
    # Return:
    #     the ten digit numbers
    def isbn_10
      isbn_array = @result["items"][0]["volumeInfo"]["industryIdentifiers"]

      isbn_array.each do |isbn|
        if isbn["type"] == "ISBN_13"
          return isbn["identifier"]
        end
      end
    end


    # It returns the thirteen digit ISBN number of book
    #
    # Example:
    #   >> gisbn.isbn_13
    #   => "9780262033848"
    #
    # Return:
    #     the thirteen digit number
    def isbn_13
      isbn_array = @result["items"][0]["volumeInfo"]["industryIdentifiers"]

      isbn_array.each do |isbn|
        if isbn["type"] == "ISBN_13"
          return isbn["identifier"]
        end
      end
    end

    # It returns categories of book
    #
    # Example:
    #   >> gisbn.categories
    #   => "Computers"
    #
    # Return:
    #     String
    def categories
      @result["items"][0]["volumeInfo"]["categories"].join(", ")
    end


    # It returns categories of book as array
    #
    # Example:
    #   >> gisbn.categories
    #   => ["Computers"]
    #
    # Return:
    #     array
    def categories_as_array
      @result["items"][0]["volumeInfo"]["categories"]
    end


    # It returns the link of small size thumbnail of book
    #
    # Example:
    #   >> gisbn.small_thumbnail
    #   => "http://books.google.com/books/content?id=i-bUBQAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api"
    #
    # Return:
    #     String
    def thumbnail_small
      @result["items"][0]["volumeInfo"]["imageLinks"]["smallThumbnail"]
    end


    # It returns the link of thumbnail of book
    #
    # Example:
    #   >> gisbn.thumbnail
    #   => "http://books.google.com/books/content?id=i-bUBQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
    #
    # Return:
    #     String
    def thumbnail
      @result["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"]
    end

    # It returns the preview link of book
    #
    # Example:
    #   >> gisbn.preview_link
    #   => "http://books.google.ca/books?id=i-bUBQAAQBAJ&printsec=frontcover&dq=isbn:0262033844&hl=&cd=1&source=gbs_api"
    #
    # Return:
    #     String
    def preview_link
      @result["items"][0]["volumeInfo"]["previewLink"]
    end

    # It returns the count of page
    #
    # Example:
    #   >> gisbn.page_count
    #   => 1292
    #
    # Return:
    #     int
    def page_count
      @result["items"][0]["volumeInfo"]["pageCount"] rescue nil
    end
  end
end
