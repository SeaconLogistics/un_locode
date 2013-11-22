module UnLocode
  class Locode < BaseRecord
    belongs_to :country

    def self.find_by_fuzzy_name name, limit = 10
      where("name like ?", "%#{name}%").limit(limit)
    end

    # search_string - The string that will be used in the LOCODE search.
    # function - Integer or :B that specifies the function of the location
    # limit - Integer to specify how many locations you want
    def find_by_name_and_function name, function, limit = 10
      return [] unless search_string.is_a?(String)
      return [] unless function.to_s =~ /^[1-7]{1}|:B{1}$/


    end

  end
end
