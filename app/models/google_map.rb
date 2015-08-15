class GoogleMap
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  include HTTParty
  include Geocoder

  base_uri 'https://www.google.com'

  def initialize(origin, destination)
    @origin = CGI::escape(Geocoder.address(origin))
    @destination = CGI::escape(Geocoder.address(destination))
  end

  def build_url

    "https://www.google.com/maps/embed/v1/directions?origin=#{@origin}&destination=#{@destination}&key=AIzaSyBJHptJsjF1gs_K-Y595e9JmUx24VMQtgo"
  end

end