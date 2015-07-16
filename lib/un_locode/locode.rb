module UnLocode
  FUNCTIONS = [:port,
               :rail_terminal,
               :road_terminal,
               :airport,
               :postal_exchange_office,
               :inland_clearance_depot,
               :fixed_transport_functions,
               :border_crossing_function].freeze

  class Locode < BaseRecord
    belongs_to :country

    def self.find_by_fuzzy_name name, limit = 10
      includes(:country).where('name like ? or
             name_wo_diacritics like ? or
             alternative_name like ? or
             alternative_name_wo_diacritics like ?',
            "%#{name}%", "%#{name}%", "%#{name}%", "%#{name}%").limit(limit)
    end

    def self.find_by_function function, limit = 10
      raise "Unsupported Locode Function! Should be one of #{UnLocode::FUNCTIONS.join(' ')}." unless UnLocode::FUNCTIONS.include?(function)
      includes(:country).where(function => true).limit(limit)
    end

    def self.find_by_name_and_function name, function, limit = 10
      find_by_fuzzy_name(name).find_by_function(function, limit)
    end

    def self.find_by_locode(locode)
      locode = locode.gsub(' ','')
      includes(:country).where(city_code: locode[2..4])
        .where(countries: { code: locode[0..1] }).first
    end

    def as_json options = {}
      super(options.merge!(except: [:id, :country_id])).merge('country' => country.as_json)
    end
  end
end
