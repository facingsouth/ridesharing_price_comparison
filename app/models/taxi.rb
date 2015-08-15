class Taxi < ActiveRecord::Base

  def starting_city_rate(start_address)
    result = Taxi.where("city_name ILIKE ?", "%#{start_address}%")
    if result.nil?
      per_mile_charge = 3
    else
      per_mile_charge = result.per_mile_charge
    end
    per_mile_charge
  end

  def total_taxi_price(start_address, end_address)

  end
end
