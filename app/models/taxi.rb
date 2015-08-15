class Taxi < ActiveRecord::Base
  include Geocoder

  def data_parser(start_address, end_address, duration, distance)
    data = {  :mode => "Local Taxi",
              :distance => distance,
              :duration => duration,
              :price    => total_taxi_price(start_address,
                                            end_address),
              :availability => 5.0 }
  end

  def distance(start_address, end_address)
    start = Geocoder.coordinates(start_address)
    destination = Geocoder.coordinates(end_address)
    Geocoder::Calculations.distance_between(start, destination)
  end

  def total_taxi_price(start_address, end_address)
    total_price = starting_city_rate(start_address) * distance(start_address, end_address)
    total_price = total_price.round(2)
    total_price = "$"+total_price.to_s
  end

  def starting_city_rate(start_address)
    result = Taxi.where("city_name ILIKE ?", "%#{start_address}%")
    if result.nil?
      result = Taxi.where("city_name ILIKE ?", "%#{start_address[0..-3]}")
      if result.nil?
        result = Taxi.where("city_name ILIKE ?", "%#{start_address[-3..-1]}%")
        result
      end
    end

    result[0].per_mile_charge
  end

  

end
