require 'active_record'
require_relative '../data/db'

module UnLocode
  UnLocode::DB.new().connect_to_db
end

require 'un_locode/base_record'
require 'un_locode/version'
require 'un_locode/country'
require 'un_locode/locode'
