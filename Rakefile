require 'bundler/gem_tasks'
require './data/locode_data_update'
require 'benchmark'

desc 'Update the datasource of the gem from csv files'
task :dataupdate do
  puts 'updating data'
  puts Benchmark.measure { LocodeDataUpdate.parse }
  puts 'end of data update'
end
