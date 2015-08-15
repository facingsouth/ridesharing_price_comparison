class DashboardsController < ApplicationController

  def new
  end

  def create
    @origin = params[:origin]
    @destination = params[:destination]
    uber = Uber.new
    data = uber.uber_type_price_distance(@origin, @destination)
    public_transit = PublicTransit.new(@origin, @destination, "transit")
    data << public_transit.data_parser
    driving = PublicTransit.new(@origin, @destination, "driving")
    data << driving.data_parser
    t = Taxi.new
    data << t.data_parser(@origin, @destination, driving.data_parser[:duration], driving.data_parser[:distance])
    redirect_to dashboard_path( data: data, origin: @origin, destination: @destination ) 
  end

  def show
    @data = params[:data]
    # map = GoogleMap.new(params[:origin], params[:destination])
    # @map = map.get_response
    @origin = CGI::escape(params[:origin])
    @destination = CGI::escape(params[:destination])
    @url = "https://www.google.com/maps/embed/v1/directions?origin=#{@origin},+United+States&destination=S#{@destination},+United+States&key=AIzaSyBJHptJsjF1gs_K-Y595e9JmUx24VMQtgo"

    # fail

  end
end
