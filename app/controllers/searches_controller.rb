class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      redirect_to @search
    else
      flash.now[:error] = "Error!"
      render :new
    end
  end

  def show
    @search = Search.find(params[:id])
    @data = @search.get_data
    map = GoogleMap.new(@search.origin, @search.destination)
    @map_url = map.build_url
    @search = Search.new
  end


  private

  def search_params
    params.require(:search).permit(:origin, :destination)
  end
end
