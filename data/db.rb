require_relative 'schema.rb'

module UnLocode
  class DB
    def initialize(name = 'db.sqlite')
      @database_name = File.expand_path(name.downcase, File.dirname(__FILE__))
    end

    def reset
      File.delete(@database_name) if File.exists?(@database_name)
      connect_to_db
      Schema.new.change
    end

    def connect_to_db
      ActiveRecord::Base.configurations.merge!(config)

      @connection ||= ActiveRecord::Base.establish_connection(:un_locode)
    end

    private

    def config
      {
        'un_locode' => {
          'adapter' => 'sqlite3',
          'database' => @database_name
        }
      }
    end
  end
end