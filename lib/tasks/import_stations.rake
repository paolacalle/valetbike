require_relative '../../config/environment'
require 'csv'

csv_file = 'notes/station-data.csv'

namespace :import do
  task :stations => :environment do
    csv_data = File.read(csv_file)
    csv = CSV.parse(csv_data, headers: true)

    csv.each do |row| 
      station_data = {}
      station_data[:identifier] = row['identifier']
      station_data[:name] = row['name']
      station_data[:address] = row['address']
      station_data[:has_kiosk] = row['has_kiosk'].to_i
      station_data[:needs_maintenance] = row['needs_maintenance'].to_i
      station_data[:dock_count] = row['dock_count'].to_i
      station_data[:docked_bike_count] = row['docked_bike_count'].to_i

      puts "Station Data: #{station_data.inspect}"


      station = Station.find_by(identifier: station_data[:identifier])
      if station.nil?
        # Create a new station
        station = Station.create!(station_data)
      else
        # Update the existing station if needed
        station.update!(station_data)
      end
      
    end

    puts "Success import of #{csv_file} into **Station** db."
  end
end
