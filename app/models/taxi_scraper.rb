require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'pry'

class Taxi

  def initialize

  end

  def read_rates
    file = File.open("taxi_rates.txt", 'r')
    while !file.eof?
      line = file.readline
      line = line.split(" ").to_a
      if line[0].include?(".")
        line.shift
      end

      

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