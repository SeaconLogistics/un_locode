module UnLocode
  class Place < ActiveRecord::Base
    belongs_to :country
    has_and_belongs_to_many :functions
  end
end
