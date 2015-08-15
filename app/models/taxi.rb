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

  def geo_address(start_address)
    @start_city = Geocoder.search(start_address).first
    @start_city.city
    @start_state = Geocoder.coordinates(start_address).state
  end

  def total_taxi_price(start_address, end_address)
    total_price = starting_city_rate(start_address) * distance(start_address, end_address)
    total_price = total_price.round(2)
    total_price = "$"+total_price.to_s
  end

  def starting_city_rate(start_address)
    geo_address(start_address)
    result = Taxi.where("city_name ILIKE ?", "%#{ @start_city }%")
    if result.nil?
      result = Taxi.where("city_name ILIKE ?", "%#{ @start_state }")
      # if result.nil?
      #   result = Taxi.where("city_name ILIKE ?", "%#{start_address[-3..-1]}%")
      #   result
    end
    result[0].per_mile_charge
  end



end
