# gisbn

It fetches book's information by ISBN number based on Google Book API.

  - Easy to get all information by ISBN
  - Structure data

You don't have to call manually Google API with ISBN number. This gem will do everything for you.



### Version
0.0.1


### Installation

You need Gulp installed globally:

```sh
gem install gisbn
```
Or, if you're using this in a project with Bundler:

```sh
gem 'imdb'
```

## Examples
    book = Gisbn::Book.new "0262033844"

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



### Development

Want to contribute? Great!

1. Fork it ( https://github.com/eftakhairul/gisbn/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


Author
-----------
[Eftakhairul Islam] - eftakhairul [at] gmail [dot] com
[Eftakhairul Islam]:http://eftakhairul.com/


License
----
MIT




