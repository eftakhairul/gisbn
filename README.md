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
    book = Gisbn::Book.new("")

    book.title
    #=> "Die Hard"

    book.description
    #=> "Bruce Willis"


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




