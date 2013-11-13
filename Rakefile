require "bundler/gem_tasks"

desc "Update the datasource of the gem from csv files"
task :dataupdate do
  require './data/locode_data_update'
  puts "updating data"
  LocodeDataUpdate.new.parse
  puts "end of data update"
end
