require 'oauth2'

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

  def authorize
    # client = OAuth2::Client.new(ENV['UBER_CLIENT_ID'],
    #                             ENV['UBER_CLIENT_SECRET'],
    #                             site: 'https://login.uber.com/oauth/authorize')
    # client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth2/callback')
    # @token = client.auth_code.get_token('authorization_code_value', 
    #                                    :redirect_uri => 'http://localhost:8080/oauth2/callback', 
    #                                    :headers => {'Authorization' => ENV['UBER_SERVER_TOKEN']})
  end

  def availability
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