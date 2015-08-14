class PublicTransit

  include HTTParty

  base_uri 'http://maps.googleapis.com'

  def initialize(origin      = "San Francisco", 
                 destination = "San Mateo")
    @data = nil
    @origin = origin
    @destination = destination
  end

  def price
    parameters = { query: {
      'key': ENV['GOOGLE_DIRECTION_API_KEY'],
      'origin': "#{@origin}",
      'destination': "#{@destination}"
      }
    }
    @data = self.class.get('/maps/api/directions/json', parameters)
  end

end