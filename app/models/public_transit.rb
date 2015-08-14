class PublicTransit

  DRIVING_COST_PER_MILE = 0.35

  include HTTParty

  base_uri 'https://maps.googleapis.com'

  def initialize(origin      = "San Francisco", 
                 destination = "San Mateo", 
                 travel_mode = "transit")
    @data = {}
    @origin = origin
    @destination = destination
    @travel_mode = travel_mode
  end

  def data_parser
    response = get_response
    return @data = { :status => "service not available" } unless response
    raise response["status"] unless response["status"] == "OK"
    @data = { :distance => distance(response),
              :duration => duration(response),
              :price    => price(response),
              :mode     => travel_mode,
              :availablity => 5.0
    }
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

  def distance(response) # In miles
    (response["routes"][0]["legs"][0]["distance"]["value"] / 1609.34).round(2)
  end

  def duration(response) # In minutes
    (response["routes"][0]["legs"][0]["duration"]["value"] / 60.to_f).round(2)
  end

  def price(response) # In USD
    if travel_mode == "transit"
      response["routes"][0]["fare"]["text"]
    elsif travel_mode == "driving"
      "$#{(distance(response) * DRIVING_COST_PER_MILE).round(2)}"
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