# gisbn GEM  [![Build Status](https://travis-ci.org/eftakhairul/gisbn.svg?branch=master)](https://travis-ci.org/eftakhairul/gisbn) [![GitHub issues](https://img.shields.io/github/issues/eftakhairul/gisbn.svg)](https://github.com/eftakhairul/gisbn/issues)  [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/eftakhairul/gisbn/master/LICENSE.txt)

It fetches book's information by ISBN number based on Google Book API.

  - Easy to get all information by ISBN
  - Structure data

You don't have to call manually Google API with ISBN number. This gem will do everything for you.



### Version
0.0.1


### Installation
Add this line to your application's Gemfile:

```ruby
gem 'gisbn'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as globally:

```sh
gem install gisbn
```


## Examples
    book = Gisbn::Book.new "0262033844", "AIzaSyDKepjfaVBRcgsnPALw5s2UNyfOk-1FHUU", "ca"

    book.title
    #=> "Introduction to Algorithms"

    book.description
    #=> "A new edition of the essential text and professional reference, with substantial newmaterial on such topics as vEB trees, multithreaded algorithms, dynamic programming, and edge-baseflow."

    book.publisher
    #=> "MIT Press"

    book.published_date
    #=> <Date: 2001-02-03 ...>

    book.isbn_10
    #=> 0262033844

    book.isbn_13
    #=> 9780262033848

    book.thumbnail
    #=> http://books.google.com/books/content?id=i-bUBQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api

    book.preview
    #=> http://books.google.ca/books?id=i-bUBQAAQBAJ&printsec=frontcover&dq=isbn:0262033844&hl=&cd=1&source=gbs_api


    book.gisbn.isbn = 9780321573513
    book.fetch.title  => "Algorithms"



## Methods
    title                >> Returns Book's title as string
    description          >> Returns the description of book as string
    isbn(isbn_number)    >> Set new isbn
    fetch                >> Call to Google Book API and process book information on provided ISBN
    authors              >> Return authors' name as comma separated as string
    authors_as_array     >> Return authors' name as ruby array. If no book is associated with ISBN number,
                            then it return empty array
    publisher            >> Return publisher name as string
    isbn_10              >> Return 10 digit ISBN numbers as string
    isbn_13              >> Return 13 digit ISBN numbers as string
    categories           >> Return category names as comma separated as string
    categories_as_array  >> Return category names as ruby array. If no book is associated with ISBN number,
                            then it return empty array
    thumbnail_small      >> Return the link of small thumnail
    thumbnail            >> Return the link of standard thumnail
    preview_link         >> Return the link for previewing the book
    page_count           >> Return page count as integer
    published_date       >> Return the published date as Ruby object


### Development

Want to contribute? Great!

1. Fork it ( https://github.com/eftakhairul/gisbn/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


Author
-----------
[Eftakhairul Islam](https://eftakhairul.com)

Contributors
[Matt Seeberger](https://github.com/thebeardedgeek)

License
----
MIT




