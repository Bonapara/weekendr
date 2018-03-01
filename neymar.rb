require 'date'
require 'json'


request_start = Time.now

journeys_serialized = File.read('deux_weekend.json')
journeys_json = JSON.parse(journeys_serialized)

journeys_json.each do |key, value|
  journeys = value["data"]

  journeys.each do |journey|
    weekend_attr = {}
    # ATTRIBUTES
    weekend_attr[:city_from]                    = journey["route"][0]["cityFrom"]
    weekend_attr[:country_from]                 = journey["countryFrom"]["name"]
    weekend_attr[:city_to]                      = journey["route"][0]["cityTo"]
    weekend_attr[:country_to]                   = journey["countryTo"]["name"]
    weekend_attr[:price]                        = journey["price"] # = journey["conversion"]["EUR"]
    weekend_attr[:booking_token]                = journey["booking_token"]
    weekend_attr[:booking_link]                 = journey["deep_link"]
    # GO_FLIGHT HASH
    weekend_attr[:go_flight]                    = {}
    weekend_attr[:go_flight][:flight_no]        = journey["route"][0]["flight_no"]
    weekend_attr[:go_flight][:airport_from]     = journey["routes"][0][0]
    weekend_attr[:go_flight][:airport_to]       = journey["route"][0][1]
    weekend_attr[:go_flight][:dTime]            = DateTime.strptime("#{journey["route"][0]["dTime"]}",'%s').strftime("%d/%m/%Y")
    weekend_attr[:go_flight][:aTime]            = DateTime.strptime("#{journey["route"][0]["aTime"]}",'%s').strftime("%d/%m/%Y")
    weekend_attr[:go_flight][:airline]          = journey["airlines"][0]
    # RETURN_FLIGHT HASH
    weekend_attr[:return_flight]                = {}
    weekend_attr[:return_flight][:flight_no]    = journey["route"][1]["flight_no"]
    weekend_attr[:return_flight][:airport_from] = journey["routes"][1][0]
    weekend_attr[:return_flight][:airport_to]   = journey["route"][1][1]
    weekend_attr[:return_flight][:dTime]        = DateTime.strptime("#{journey["route"][1]["dTime"]}",'%s').strftime("%d/%m/%Y")
    weekend_attr[:return_flight][:aTime]        = DateTime.strptime("#{journey["route"][1]["aTime"]}",'%s').strftime("%d/%m/%Y")
    weekend_attr[:go_flight][:airline]          = journey["airlines"][1]

    puts weekend_attr
  end

end

request_end = Time.now
puts "#{request_end - request_start} seconds"
