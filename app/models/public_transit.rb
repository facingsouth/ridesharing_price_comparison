require 'oauth2'

class PublicTransit

  include HTTParty

  base_uri 'https://maps.googleapis.com'

  def initialize(origin      = "San Francisco", 
                 destination = "San Mateo", 
                 travel_mode = "transit")
    @data = []
    @origin = origin
    @destination = destination
    @travel_mode = travel_mode
  end

  def data_parser
    response = get_response
    return nil unless response
    raise response["status"] unless response["status"] == "OK"
    @data = [distance(response), duration(response), price(response)]
  end

  private

  def get_response
    parameters = { query: {
      'key': ENV['GOOGLE_DIRECTION_API_KEY'],
      'origin': "#{origin}",
      'destination': "#{destination}",
      'mode': travel_mode
      }
    }
    self.class.get('/maps/api/directions/json', parameters)
  end

  def distance(response) # In meters
    response["routes"][0]["legs"][0]["distance"]["value"]
  end

  def duration(response) # In seconds
    response["routes"][0]["legs"][0]["duration"]["value"]
  end

  def price(response)
    if travel_mode == "transit"
      response["routes"][0]["fare"]["value"]
    end
  end

  def origin
    @origin
  end

  def destination
    @destination
  end

  def travel_mode
    @travel_mode
  end

end