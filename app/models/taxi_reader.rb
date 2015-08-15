# require 'nokogiri'
# require 'open-uri'
# require 'mechanize'
# require 'pry'

class TaxiReader

  def initialize

  end

  def read_rates
    file = File.open("./app/models/taxi_rates.txt", 'r')
    while !file.eof?
      line = file.readline
      line = line.split("$")
      # if line[1].nil?
      #   break
      # end
      # puts line
      # if line[0].include?(".")
      #   line[0] = line[0].split(/.(.+)?/)[1]
      #   line[0] = line[0][1]
      Taxi.create(:city_name => line[0],
                 :initial_charge => line[1].to_f,
                 :per_mile_charge => line[2].to_f,
                 :typical_short_fare => line[3].to_f,
                 :typical_medium_fare => line[4].to_f,
                 :typical_long_fare => line[5].to_f)
    end
  end

  # def initialize
  #   @mech = Mechanize.new
  # end

  # def main
  #   result = submit_search_query("isla vista", "santa barbara")
  #   result.parser
  #   binding.pry
  #   fare = find_fare(result)
  #   fare
  # end

  # def find_fare(result)
  #   fare = result.css("#main-resultFare")
  #   fare
  # end

  # def submit_search_query(start_address, end_address)
  #   start_address = CGI.escape(start_address)
  #   end_address = CGI.escape(end_address)
  #   @mech.get("http://www.taxifarefinder.com/main.php?city=Emerald-Isle-NC&from=#{start_address}&to=#{end_address}")
  # end

    #taxi fare finder really hard wtf
  # def taxi_search_page
  #   @mech.get("http://www.taxifarefinder.com/")
  # end

  # def submit_search_query(page, start_address, end_address)
  #   # submit_query = page.form_with(:id => 'indexForm-steps')
  #   submit_query = page.search('#indexForm-steps')
  #   submit_query_from = form.field_with(:id => "fromCoord") 
  #   submit_query_from.value = start_address
  #   submit_query_to = form.field_with(:id => "toAddress") 
  #   submit_query_to.value = end_address
  #   @mech.submit(submit_query, submit_query.button.last)
  # end

end