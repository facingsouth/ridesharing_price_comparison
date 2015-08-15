class DashboardsController < ApplicationController

  def new
  end

  def create
    @origin = params[:origin]
    @destination = params[:destination]
    # uber = Uber.new
    # data = uber.uber_type_price_distance(@origin, @destination)
  data = []
    public_transit = PublicTransit.new(@origin, @destination, "transit")
    data << public_transit.data_parser
    driving = PublicTransit.new(@origin, @destination, "driving")
    data << driving.data_parser
    redirect_to dashboard_path( data: data ) 
  end

  def show
    @data = params[:data]
  end
end
