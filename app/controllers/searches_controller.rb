class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      redirect_to search
    else
      flash.now[:error] = "Error!"
      render :new
    end
  end

  def show
    @search = Search.find(params[:id])
    @data = @search.get_data
    # map = GoogleMap.new(params[:origin], params[:destination])
    # @map = map.get_response
    @origin = CGI::escape(@search.origin)
    @destination = CGI::escape(@search.destination)
    @url = "https://www.google.com/maps/embed/v1/directions?origin=#{@origin},+United+States&destination=S#{@destination},+United+States&key=AIzaSyBJHptJsjF1gs_K-Y595e9JmUx24VMQtgo"
    @search = Search.new
  end


  private

  def search_params
    params.require(:search).permit(:origin, :destination)
  end
end
