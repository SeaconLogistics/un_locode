module UnLocode
  module DB
    def self.database_name
      File.expand_path('../../../data/db.sqlite', __FILE__)
    end

    def self.config
      {
        'un_locode' => {
          'adapter' => 'sqlite3',
          'database' => database_name
        }
      }
    end

    def self.connection
      ActiveRecord::Base.configurations = UnLocode::DB.config
      @connection ||= ActiveRecord::Base.establish_connection :un_locode
    end

  end
end
