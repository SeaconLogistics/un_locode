# Locode

The Locode gem gives you the ability to lookup UN/LOCODE codes. You can read more about the UN/LOCODE specifications here: [wiki](http://en.wikipedia.org/wiki/UN/LOCODE).

All data used by this gem has been taken from the *UN Centre for Trade Facilitation and E-business* official website. **No guarantees for the accuracy or up-to-dateness are given.**

`http://www.unece.org/cefact/locode/welcome.html` and `http://www.unece.org/cefact/codesfortrade/codes_index.html`

## Installation

Add this line to your application's Gemfile:

    gem 'un_locode'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install un_locode

## Usage

Find locations whose name is like the supplied search string. The search is case insensitive and also tries to match
location name without diacritics (and also alternative names when available). By default the amount of locations
returned are 10 but you can override this value by passing a number as second argument.

    UnLocode::Locode.find_by_fuzzy_name('Göte', 5)
    #=> [#<UnLocode::Locode city_code: "GOT", name: "Göteborg", ...


Same search mechanisms as above but filter by function. You can find a list of possible functions @ UnLocode::FUNCTIONS.
Like above you can limit the query result.

    UnLocode::Locode.find_by_name_and_function('US', :port)
    #=> [<UnLocode::Locode: city_code: "GOT", name: ">,>
         <UnLocode::Locode: 'US LAX'>, ... ]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request