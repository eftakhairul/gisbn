#require all files
require "gisbn/version"
require 'rubygems'
require 'net/http'
require 'json'


module Gisbn

  class Book

    attr_reader :result, :isbn

    private
    attr_accessor :key, :country

    BASE_URL = 'https://www.googleapis.com/books/v1/volumes?q=isbn:'

    public
    # Initialize a new Book object by ISBN (either ten or thirteen digit ISBN numbers)
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
      @key      = key
      @country  = country

      fetch
    end


    # Fetch book info from Google API
    #
    # Example:
    #   >> gisbn.fetch
    #   => #<Gisbn::Book:0x007fc08525e688 @isbn="0262033844", @result={"kind"=>"books#volumes", "totalItems"=>1, "items"=>[{"kind"=>"books#volume",
    #   "id"=>"i-bUBQAAQBAJ", "etag"=>"a0y8TyrBWu0", "selfLink"=>"https://www.googleapis.com/books/v1/volumes/i-bUBQAAQBAJ",
    #   "volumeInfo"=>{"title"=>"Introduction to Algorithms", "authors"=>["Thomas H. Cormen"], "publisher"=>"MIT Press", "publishedDate"=>"2009-07-31",
    #   "description"=>"A new edition of the essential text and professional reference, with substantial newmaterial on such topics as vEB trees,
    #   multithreaded algorithms, dynamic programming, and edge-baseflow.", "industryIdentifiers"=>[{"type"=>"ISBN_13", "identifier"=>"9780262033848"},
    #   {"type"=>"ISBN_10", "identifier"=>"0262033844"}], "readingModes"=>{"text"=>false, "image"=>true}, "pageCount"=>1292, "printType"=>"BOOK",
    #   "categories"=>["Computers"], "averageRating"=>4.0, "ratingsCount"=>16, "contentVersion"=>"preview-1.0.0",
    #   "imageLinks"=>{"smallThumbnail"=>"http://books.google.com/books/content?id=i-bUBQAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
    #   "thumbnail"=>"http://books.google.com/books/content?id=i-bUBQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"}, "language"=>"en",
    #   "previewLink"=>"http://books.google.ca/books?id=i-bUBQAAQBAJ&printsec=frontcover&dq=isbn:0262033844&hl=&cd=1&source=gbs_api",
    #   "infoLink"=>"http://books.google.ca/books?id=i-bUBQAAQBAJ&dq=isbn:0262033844&hl=&source=gbs_api", "canonicalVolumeLink"=>"http://books.google.ca/books/about/Introduction_to_Algorithms.html?hl=&id=i-bUBQAAQBAJ"},
    #   "saleInfo"=>{"country"=>"CA", "saleability"=>"NOT_FOR_SALE", "isEbook"=>false}, "accessInfo"=>{"country"=>"CA", "viewability"=>"PARTIAL",
    #   "embeddable"=>true, "publicDomain"=>false, "textToSpeechPermission"=>"ALLOWED", "epub"=>{"isAvailable"=>false}, "pdf"=>{"isAvailable"=>false},
    #   "webReaderLink"=>"http://books.google.ca/books/reader?id=i-bUBQAAQBAJ&hl=&printsec=frontcover&output=reader&source=gbs_api",
    #   "accessViewStatus"=>"SAMPLE", "quoteSharingAllowed"=>false}, "searchInfo"=>{"textSnippet"=>"A new edition of the essential text
    #   and professional reference, with substantial newmaterial on such topics as vEB trees, multithreaded algorithms, dynamic programming, and
    #   edge-baseflow."}}]}
    #
    # Return
    #     JSON
    def fetch
      response  = Net::HTTP.get_response(URI.parse(BASE_URL + "#{@isbn}&key=#{@key}&country=#{@country}")).body
      @result   = JSON.parse(response)
      @result   = nil if @result["totalItems"] == 0
    end


    # Set ISBN for new request
    #
    # Arguments:
    #   isbn: (String)
    #
    # Example:
    #   >> gisbn.isbn = 0262033844
    #
    # Return
    #     Gisbn
    def isbn(isbn)
      isbn.strip! || isbn
    end


    # Description of the book
    #
    # Example:
    #   >> gisbn.description
    #   => "A new edition of the essential text and professional reference, with substantial newmaterial on such topics as vEB trees,
    #       multithreaded algorithms, dynamic programming, and edge-baseflow."
    #
    # Return:
    #     String
    def description
      return nil if @result.nil?
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
      return nil if @result.nil?
      @result["items"][0]["volumeInfo"]["title"]
    end


    # It returns all authors' name as comma separated string
    #
    # Example:
    #   >> gisbn.authors
    #   => "harles E. Leiserson, Clifford Stein, Ronald Rivest,Thomas H. Cormen"
    #
    # Return:
    #     String
    def authors
      return nil if @result.nil?
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
      return Array.new if @result.nil?
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
      return nil if @result.nil?
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
      return nil if @result.nil?

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
      return nil if @result.nil?

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
      return nil if @result.nil?
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
      return Array.new if @result.nil?
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
      return nil if @result.nil?
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
      return nil if @result.nil?
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
      return nil if @result.nil?
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
      return 0 if @result.nil?
      @result["items"][0]["volumeInfo"]["pageCount"]
    end


    # It returns the published date
    #
    # Example:
    #   >> gisbn.published_date
    #   => #<Date: 2009-07-31 ((2455044j,0s,0n),+0s,2299161j)>
    #
    # Return:
    #     Date
    def published_date
      return nil if @result.nil?
      Date.parse(@result["items"][0]["volumeInfo"]["publishedDate"])
    end
  end
end
