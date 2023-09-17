require_relative '../../config/environment'
require 'csv'
csv_file = 'notes/bike-data.csv'

namespace :import do
  task :bikes => :environment do

    CSV.foreach(csv_file, headers: true) do |row|
      Bike.create!(
        identifier: row['identifier'],
        current_station_id: row['current_station_identifier'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      )
    end

    puts "Success import of #{csv_file} into **Bike** db."
  end
end


# csv_text = File.read('notes/bike-data.csv')
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#     CreateBikes.create!(row.to_hash)
# end

# namespace :import do
#     desc "Import data from stations.csv"
#     task :bikes => :environment do
#       require 'csv'
#       csv_text = File.read('notes/bike-data.csv')
  
#       CSV.parse(csv_text, headers: true) do |row|
#         CreateBikes.create!(row.to_hash)
#       end
#     end
#   end