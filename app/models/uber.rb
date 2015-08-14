class Uber

  def initialize
    @data = nil
  end

  def availability
    parameters = { query: {
      'server_token': ENV['UBER_SERVER_TOKEN'],
      'latitude': 37.775818,
      'longitude': -122.418028,
      }
    }
    @data = HTTParty.get('https://sandbox-api.uber.com/v1/products', parameters)
  end

end