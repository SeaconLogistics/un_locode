require 'csv'
require 'pry'
require 'yaml'
require_relative '../lib/un_locode'
require_relative 'schema.rb'

class LocodeDataUpdate

  def self.parse
    reset_db
    parse_locodes
  end

  private

  def self.parse_locodes
    Dir.glob('./data/csv/*.csv') do |file|
      CSV.parse(File.open(file, 'r:ISO-8859-1')) do |row|
        if country_row?(row)
          parse_country(row)
        else locode_row?(row)
          parse_locode(row)
        end
      end
    end
  end

  def self.parse_country row
    country_code = row[1]
    country_name = row[3].gsub('.', '')

    UnLocode::Country.create(code: country_code, name: country_name)
  end

  # sample input: "--34-6--"
  def self.parse_function_attributes str_function
    function_array = str_function.split(//)
    {
      port: function_array[0] == '1',
      rail_terminal: function_array[1] == '2',
      road_terminal: function_array[2] == '3',
      airport: function_array[3] == '4',
      postal_exchange_office: function_array[4] == '5',
      inland_clearance_depot: function_array[5] == '6',
      fixed_transport_functions: function_array[6] == '7',
      border_crossing_function: function_array[7].try(:upcase) == 'B'
    }
  end

  def self.parse_name_attr name, name_wo_diacritics
    {
      name:               name.strip,
      name_wo_diacritics: name_wo_diacritics.strip,
    }
  end

  #As a service to users, names that have been changed may be included for reference. Such alternative
  #name versions are included as a transitional measure after a name change; they are followed by an
  #equal sign (=), e.g.:
  #
  #Peking = Beijing
  #Leningrad = St Petersburg
  #
  #The code element will be shown only under the new name.
  def self.parse_name_attr_with_alternatives name, name_wo_diacritics
    {
      name:                           name.split('=').last.strip,
      name_wo_diacritics:             name_wo_diacritics.split('=').last.strip,
      alternative_name:               name.split('=').first.strip,
      alternative_name_wo_diacritics: name_wo_diacritics.split('=').first.strip
    }
  end

  def self.has_alternatives? changes
    changes == '='
  end

  def self.parse_locode row
    country = UnLocode::Country.find_by_code(row[1])
    function_attr = parse_function_attributes(row[6])
    name_attr = has_alternatives?(row[0]) ? parse_name_attr_with_alternatives(row[3], row[4]) : parse_name_attr(row[3], row[4])

    location_attributes = {
      change_marker:      row[0],
      country:            country,
      city_code:          row[2],
      sub_div:            row[5],
      status:             row[7],
      date:               row[8],
      iata:               row[9],
      coordinates:        row[10],
      remarks:            row[11]
    }
    location_attributes.merge!(function_attr).merge!(name_attr)

    UnLocode::Locode.create(location_attributes)
  end

  def self.reset_db
    File.delete(UnLocode::DB.database_name) if File.exists?(UnLocode::DB.database_name)
    ActiveRecord::Base.configurations = UnLocode::DB.config
    ActiveRecord::Base.establish_connection 'un_locode'
    Schema.new.change
  end

  def self.country_row?(row)
    !!row[1] && !!row[3] && row[3][0] == '.'
  end

  def self.locode_row?(row)
    !row[2].nil?
  end
end
