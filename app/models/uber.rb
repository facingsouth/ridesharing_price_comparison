

class Uber
  include Geocoder
  include HTTParty

  base_uri 'https://api.uber.com'

  def uber_type_price_distance(start_address, end_address)
    set_trip_coordinates(start_address, end_address)
    result = []
    price_data = price_estimates
    price_data['prices'].each do |mode|
      result << { :mode => mode['localized_display_name'],
                  :price => mode['estimate'],
                  :distance => mode['distance'],
                  :duration => duration_in_minutes(mode['duration']),
                  :availability => estimate_uber_availability(mode['surge_multiplier'])}
    end
    result
  end

  private

  def duration_in_minutes(duration_in_seconds)
    (duration_in_seconds / 60.to_f).round
  end

  def estimate_uber_availability(surge)
    # Setting 5 as the max ease of getting Uber
    surge - 1 > 0 ? (5/surge).round(1) : 5.0
  end

  # Sets the lat and long for a search
  def set_trip_coordinates(start_address, end_address)
    start_address_coordinates = address_to_coordinates(start_address)
    @start_lat, @start_lon = start_address_coordinates[0], start_address_coordinates[1]
    end_address_coordinates = address_to_coordinates(end_address)
    @end_lat, @end_lon = end_address_coordinates[0], end_address_coordinates[1]
  end

  # Returns a list of options available in the area along with pricing information
  def options_available
    parameters = { query: { 'server_token'=> ENV['UBER_SERVER_TOKEN'],
                            'latitude'=> 37.775818,
                            'longitude'=> -122.418028 } }
    self.class.get('/v1/products', parameters)
  end

  # Returns price estimates for trip sorted by each Uber mode/option
  def price_estimates
    parameters = { query: { 'server_token'=> ENV['UBER_SERVER_TOKEN'],
                            'start_latitude'=> @start_lat,
                            'start_longitude'=> @start_lon,
                            'end_latitude'=> @end_lat,
                            'end_longitude'=> @end_lon } }
    self.class.get('/v1/estimates/price', parameters)
  end


  # Returns an array with [lat, long]
  def address_to_coordinates(user_address)
    Geocoder.coordinates(user_address)
  end

  # Returns a string with the address
  def coordinates_to_address(lat, long)
    Geocoder.address([lat, long])
  end

end



  # ----------
  # OAuth to be implemented
  # def authorize
  #   client = OAuth2::Client.new(ENV['UBER_CLIENT_ID'],
  #                               site: 'https://login.uber.com/oauth/authorize')
  #   client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth2/callback')
  #   @token = client.auth_code.get_token(client_secret: ENV['UBER_CLIENT_SECRET'],
  #                                       client_id: ENV['UBER_CLIENT_ID'],
  #                                       grant_type: 'authorization_code',
  #                                       redirect_uri: 'http://localhost:8080',
  #                                       code:'authorization_code',
  #                                       headers: {'Authorization' => ENV['UBER_SERVER_TOKEN']})
  # end

  # Methods not needed anymore

  #   def initialize(start_lat = 37.775818,
  #                start_lon = -122.418028,
  #                end_lat   = 37.005818,
  #                end_lon   = -122.000028)
  #   @start_lat = start_lat
  #   @start_lon = start_lon
  #   @end_lat = end_lat
  #   @end_lon = end_lon
  # end