require 'date'
require 'json'
require 'open-uri'
# method computing next date of a given day
def date_of_next(day)
  date  = Date.parse(day)
  delta = date > Date.today ? 0 : 7
  date + delta
end

# Parameters of the search
go_day = "Friday"
return_day = "Sunday"
go_hours_range = {from: "18%3A00",to: "23%3A59"}
return_hours_range = {from: "18%3A00",to: "23%3A59"}
city_from = "PAR"
city_to = "MAD"
weekends_number = 10


# day => date using date_of_next method make it understandable for URL
go_date = date_of_next("#{go_day}")
return_date = date_of_next("#{return_day}")

# Start time calculation
request_start = Time.now

# Start LOOP
weekends_number.times do

# Call API
url = "https://api.skypicker.com/flights?
flyFrom=#{city_from}
&to=#{city_to}
&dateFrom=#{go_date.strftime("%d/%m/%Y")}
&dateTo=#{go_date.strftime("%d/%m/%Y")}
&dtimefrom=#{go_hours_range[:from]}
&dtimeto=#{go_hours_range[:to]}
&returnFrom=#{return_date.strftime("%d/%m/%Y")}
&returnTo=#{return_date.strftime("%d/%m/%Y")}
&returndtimefrom=#{return_hours_range[:from]}
&returndtimeto=#{return_hours_range[:to]}
&directFlights=1
&partner=picky
&partner_market=eu
&limit=1"

# CALL API
weekends_serialized = open(url).read
weekends_json = JSON.parse(weekends_serialized)
weekends = weekends_json["data"]

# RETRIEVE DATA FROM JSON
weekends.each do |weekend|
  weekend_attr = {}
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
  weekend_attr[:go_flight][:airport_to]       = weekend["route"][0][1]
  weekend_attr[:go_flight][:dTime]            = DateTime.strptime("#{weekend["route"][0]["dTime"]}",'%s')
  weekend_attr[:go_flight][:aTime]            = DateTime.strptime("#{weekend["route"][0]["aTime"]}",'%s')
  weekend_attr[:go_flight][:airline]          = weekend["airlines"][0]
  # RETURN_FLIGHT HASH
  weekend_attr[:return_flight]                = {}
  weekend_attr[:return_flight][:flight_no]    = weekend["route"][1]["flight_no"]
  weekend_attr[:return_flight][:airport_from] = weekend["routes"][1][0]
  weekend_attr[:return_flight][:airport_to]   = weekend["route"][1][1]
  weekend_attr[:return_flight][:dTime]        = DateTime.strptime("#{weekend["route"][1]["dTime"]}",'%s')
  weekend_attr[:return_flight][:aTime]        = DateTime.strptime("#{weekend["route"][1]["aTime"]}",'%s')
  weekend_attr[:go_flight][:airline]          = weekend["airlines"][1]

  puts weekend_attr
end
# NEXT WEEKEND
go_date = go_date + 7
return_date = return_date + 7
end

request_end = Time.now
puts "#{request_end - request_start} seconds"

