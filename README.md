# Locode

[![Build Status](https://travis-ci.org/kabisaict/un_locode.png)](https://travis-ci.org/kabisaict/un_locode)
[![Gem Version](https://badge.fury.io/rb/un_locode.png)](http://badge.fury.io/rb/un_locode)

The un_locode gem gives you the ability to lookup UN/LOCODE codes. You can read more about the UN/LOCODE specifications here: [wiki](http://en.wikipedia.org/wiki/UN/LOCODE) and [UNECE](http://www.unece.org/fileadmin/DAM/cefact/locode/Service/LocodeColumn.htm).

All data used by this gem has been taken from the *UN Centre for Trade Facilitation and E-business* official website. **No guarantees for the accuracy or up-to-dateness are given.**

`http://www.unece.org/cefact/locode/welcome.html` and `http://www.unece.org/cefact/codesfortrade/codes_index.html` and `http://www.unece.org/fileadmin/DAM/cefact/locode/Service/LocodeColumn.htm`

Unlike the [locode gem](https://github.com/patrickdet/locode) by [patrickdet](https://github.com/patrickdet) our implementation uses a local sqlite DB to search for locodes instead of loading all the locodes(~90000) into memory. Therefore our gem only uses a fraction of the memory needed by the [locode gem](https://github.com/patrickdet/locode).  

## Installation

Add this line to your application's Gemfile:

    gem 'un_locode'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install un_locode

## Usage

- **find_by_fuzzy_name**: Find locations whose name is like the supplied search string. The search is case insensitive and also tries to match
location name without diacritics (and also alternative names when available). By default the amount of locations
returned are 10 but you can override this value by passing a number as second argument.

        UnLocode::Locode.find_by_fuzzy_name('Göte', 5)
        #=> ActiveRecord::Relation [#<UnLocode::Locode city_code: "GOT", name: "Göteborg", ...

- **find_by_name_and_function**: Same search mechanisms as above but filter by function. You can find a list of possible functions @ UnLocode::FUNCTIONS.
Like above you can limit the query result.

        UnLocode::Locode.find_by_name_and_function('US', :port)
        #=> ActiveRecord::Relation [#<UnLocode::Locode name: "Abu Musa", ... >, #<UnLocode::Locode name: "Mussafah",...>, ...
    
- **find_by_function**: Find all locations for a certain function.You can find a list of possible functions @ UnLocode::FUNCTIONS. Like all find methods, the default limit is 10 but can be specified to your own needs.

        UnLocode::Locode.find_by_function(:port, 2)
        #=> <UnLocode::Locode name: "Abu al Bukhoosh", port: true, ...>, #<UnLocode::Locode name: "Abu Dhabi", port: true>]>

#### Available functions
 - :port
 - :rail_terminal
 - :road_terminal
 - :airport
 - :postal_exchange_office
 - :inland_clearance_depot
 - :fixed_transport_functions
 - :border_crossing_function
 
 You can find more explaination of the functions over [here](http://www.unece.org/fileadmin/DAM/cefact/locode/Service/LocodeColumn.htm)
 
## TODO's
- add locode method to location (also export with as_json)
- add tests for limit's
- add find_by_locode method
- use connectionpool for connection management
- make logging configurable option

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request