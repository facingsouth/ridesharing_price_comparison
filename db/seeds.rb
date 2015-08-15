Taxi.destroy_all

def read_rates
  file = File.open("./app/models/taxi_rates.txt", 'r')
  while !file.eof?
    line = file.readline
    line = line.split("$")
    Taxi.create(:city_name => line[0].strip,
               :initial_charge => line[1].to_f,
               :per_mile_charge => line[2].to_f,
               :typical_short_fare => line[3].to_f,
               :typical_medium_fare => line[4].to_f,
               :typical_long_fare => line[5].to_f)
  end
end

read_rates