module UnLocode
  class BaseRecord < ActiveRecord::Base
    self.abstract_class = true
    establish_connection 'un_locode'
  end
end
