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
    @data, city_name = @search.get_data

    # Create historicals from the search results
    @data.each do |d|
      @search.historicals.create(type_of_service:    d[:mode],
                                 availability:       d[:availability],
                                 city_name:          city_name,
                                 avg_price_per_mile: d[:price].split("$")[1].to_f / d[:distance])
    end

    # Prepare imbeded google map
    map = GoogleMap.new(@search.origin, @search.destination)
    @map_url = map.build_url
    @search = Search.new
  end


  private

  def search_params
    params.require(:search).permit(:origin, :destination)
  end
end
