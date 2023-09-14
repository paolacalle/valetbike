require_relative '../../config/environment'
require 'csv'
csv_file = 'notes/station-data.csv'

namespace :import do
    task :stations => :environment do
        
        CSV.foreach(csv_file, headers: true) do |row|
            Station.create!(
            identifier: row['identifier'],
            name: row['name'],
            address: row['address'],
            created_at: row['created_at'],
            updated_at: row['updated_at']
            )
        end
        puts "Success import of #{csv_file} into **Station** db."
    end
end