module UnLocode
  class Country < ActiveRecord::Base
    has_many :locodes
  end
end
