class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    if signed_in_user?
      @search = current_user.searches.new(search_params)
    else
      @search = Search.new(search_params)
    end
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
      if (price = d[:price].split("$")[1].to_f) > 0
        price_per_mile = (price / d[:distance]).round(2)
      else
        price_per_mile = "N/A"
      end
      @search.historicals.create(type_of_service:    d[:mode],
                                 availability:       d[:availability],
                                 city_name:          city_name,
                                 avg_price_per_mile: price_per_mile)
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
