class GoogleMap
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  include HTTParty
  include Geocoder

  base_uri 'https://www.google.com'

  def initialize(origin, destination)
    @origin = CGI::escape(Geocoder.address(origin))
    @destination = CGI::escape(Geocoder.address(destination))
  end

  def geo_address(start_address)
    @start_city = Geocoder.search(@origin).first
    @start_state = Geocoder.search(start_address).first
  end

  def address_to_coordinates(user_address)
    Geocoder.coordinates(user_address)
  end

  def build_url
    url_string = "https://www.google.com/maps/embed/v1/directions?origin=#{@origin}&destination=#{@destination}&key=AIzaSyBJHptJsjF1gs_K-Y595e9JmUx24VMQtgo"
    url_string
  end

end