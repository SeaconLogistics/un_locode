module UnLocode
  class Country < BaseRecord
    has_many :locodes

    def as_json options = {}
      super options.merge(except: [:id])
    end
  end
end
