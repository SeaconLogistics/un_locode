module UnLocode
  class Function < ActiveRecord::Base
    has_and_belongs_to_many :places
  end
end
