class GoogleMap
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  include HTTParty

  base_uri 'https://www.google.com'

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end


  def get_response
    parameters = { query: {
      :key => ENV['GOOGLE_EMBEDED_KEY'],
      :origin => @origin,
      :destination => @destination,
      }
    }
    self.class.get('/maps/api/directions', parameters)
  end

end