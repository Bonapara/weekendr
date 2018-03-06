require 'date'
require 'json'
require 'open-uri'

module Wknd
  class ApiResponse

    attr_accessor :go_day, :return_day
    def initialize ( attributes = {} )
      @go_day             = attributes[:go_day]
      @return_day         = attributes[:return_day]
      @go_hours_range     = attributes[:go_hours_range]
      @return_hours_range = attributes[:return_hours_range]
      @city_from          = attributes[:city_from]
      @city_to            = attributes[:city_to]
    end

    def date_of_next(day)
      date  = Date.parse(day)
      delta = date > Date.today ? 0 : 7
      date + delta
    end
    def go_date
      # return go date just if it's not defined
      return @go_date ||= date_of_next(go_day)
    end

    def return_date
      # return return date just if it's not defined but not ||= because there is a if
      return @return_date if defined?(@return_date)

      @return_date = date_of_next(return_day)

      if go_date > @return_date
        @return_date = @return_date + 7
      end

      return @return_date
    end

    # Parameters of the search
    def call_date(go_date, return_date)

url = "https://api.skypicker.com/flights?
flyFrom=#{@city_from}
&to=#{@city_to}
&dateFrom=#{go_date.strftime("%d/%m/%Y")}
&dateTo=#{go_date.strftime("%d/%m/%Y")}
&dtimefrom=#{@go_hours_range[:from]}
&dtimeto=#{@go_hours_range[:to]}
&returnFrom=#{return_date.strftime("%d/%m/%Y")}
&returnTo=#{return_date.strftime("%d/%m/%Y")}
&returndtimefrom=#{@return_hours_range[:from]}
&returndtimeto=#{@return_hours_range[:to]}
&directFlights=1
&partner=picky
&partner_market=eu
&limit=1"
      # CALL API with gsub because of lines return
      weekends_serialized = open(url.gsub!(/\n/,'')).read
      weekends_json = JSON.parse(weekends_serialized)
      weekends = weekends_json["data"]
      # RETRIEVE DATA FROM JSON
      weekend_attr = {}
      weekends.each do |weekend|
        # WEEKEND ATTRIBUTES
        weekend_attr[:city_from]                    = weekend["route"][0]["cityFrom"]
        weekend_attr[:country_from]                 = weekend["countryFrom"]["name"]
        weekend_attr[:city_to]                      = weekend["route"][0]["cityTo"]
        weekend_attr[:country_to]                   = weekend["countryTo"]["name"]
        weekend_attr[:price]                        = weekend["price"] # = weekend["conversion"]["EUR"]
        weekend_attr[:booking_token]                = weekend["booking_token"]
        weekend_attr[:booking_link]                 = weekend["deep_link"]
        # GO_FLIGHT HASH
        weekend_attr[:go_flight]                    = {}
        weekend_attr[:go_flight][:flight_no]        = weekend["route"][0]["flight_no"]
        weekend_attr[:go_flight][:airport_from]     = weekend["routes"][0][0]
        weekend_attr[:go_flight][:airport_to]       = weekend["routes"][0][1]
        weekend_attr[:go_flight][:dTime]            = DateTime.strptime("#{weekend["route"][0]["dTime"]}",'%s')
        weekend_attr[:go_flight][:aTime]            = DateTime.strptime("#{weekend["route"][0]["aTime"]}",'%s')
        weekend_attr[:go_flight][:airline]          = weekend["route"][0]["airline"]
        # RETURN_FLIGHT HASH
        weekend_attr[:return_flight]                = {}
        weekend_attr[:return_flight][:flight_no]    = weekend["route"][1]["flight_no"]
        weekend_attr[:return_flight][:airport_from] = weekend["routes"][1][0]
        weekend_attr[:return_flight][:airport_to]   = weekend["routes"][1][1]
        weekend_attr[:return_flight][:dTime]        = DateTime.strptime("#{weekend["route"][1]["dTime"]}",'%s')
        weekend_attr[:return_flight][:aTime]        = DateTime.strptime("#{weekend["route"][1]["aTime"]}",'%s')
        weekend_attr[:return_flight][:airline]      = weekend["route"][1]["airline"]
      end
      return weekend_attr
    end


  end
end
