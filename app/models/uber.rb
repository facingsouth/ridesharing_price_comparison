

class Uber

  include HTTParty

  base_uri 'https://sandbox-api.uber.com'

  def initialize(start_lat = 37.775818, 
                 start_lon = -122.418028, 
                 end_lat   = 37.005818, 
                 end_lon   = -122.000028)
    @data = nil
    @start_lat = start_lat
    @start_lon = start_lon
    @end_lat = end_lat
    @end_lon = end_lon

  end


  def products
    parameters = { query: {
      'server_token': ENV['UBER_SERVER_TOKEN'],
      'latitude': 37.775818,
      'longitude': -122.418028,
      }
    }
    # @data = self.class.get('/v1/products', parameters)
    response = @token.get('/v1/products', parameters)
  end

  def price
    parameters = { query: {
      'server_token': ENV['UBER_SERVER_TOKEN'],
      'start_latitude': @start_lat,
      'start_longitude': @start_lon,
      'end_latitude': @end_lat,
      'end_longitude': @end_lon
      }
    }
    @data = self.class.get('/v1/estimates/price', parameters)
  end

end