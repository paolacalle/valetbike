# This task imports bike data from a CSV file 
# Use before importing bike data 
# Usage: rake db:import_stations["notes/station-data.csv"]

namespace :db do 

  desc "Import station data from csv file"

  task :import_stations, [:filename] =>  :environment do |task, args|
    require 'csv'

    puts "Importing station data..."

    CSV.parse(File.read(args[:filename]), headers: true).each do |row|
      puts "Importing: #{row.to_hash["name"]}\n"
      import_station(row.to_hash)
    end
  end 

  def import_station(item)
    station = Station.new({
      identifier: item["identifier"],
      name: item["name"],
      address: item["address"]})

    location = Location.new({
      name: station["name"],
      address: station["address"]
    })

    location.geocode

    if station.save
      puts "Successfully imported: #{item["name"]}\n"

      if location.save
        puts "Sussessfuly saved geocordinates for #{item["name"]}"
      else 
        puts "Failed to save geocordinates for #{item["name"]}"
      end

    else 
      puts "Failed to import:  #{item["name"]}\n"
    end 

  end 

end

