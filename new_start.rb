require 'date'
require 'json'
require 'open-uri'


## method computing date of next given day such as "friday"
def date_of_next(day)
  date  = Date.parse(day)
  delta = date > Date.today ? 0 : 7
  date + delta
end

############################
# Parameters of the search #
############################
wknd_dep_from_day_pattern = "Friday"
wknd_ret_from_day_pattern = "Sunday"
hours_dep = {from: "18%3A00",to: "23%3A59"}
hours_ret = {from: "18%3A00",to: "23%3A59"}
city_from = "PAR"
city_to = "MAD"
next_weekends_to_check = 1
#############################


## Appel de la méthode "date_of_next_day" pour definir "wknd_dep_from_day", la date du prochain "wknd_dep_from_day_pattern"
wknd_dep_from_day = date_of_next("#{wknd_dep_from_day_pattern}")
wknd_ret_from_day = date_of_next("#{wknd_ret_from_day_pattern}")

request_start = Time.now

# Tableau vide pour accueillir les résultats
flights_formatted = []

# Boucle sur les weekends
next_weekends_to_check.times do

  url = "https://api.skypicker.com/flights?
  flyFrom=#{city_from}
  &to=#{city_to}
  &dateFrom=#{wknd_dep_from_day.strftime("%d/%m/%Y")}
  &dateTo=#{wknd_dep_from_day.strftime("%d/%m/%Y")}
  &dtimefrom=#{hours_dep[:from]}
  &dtimeto=#{hours_dep[:to]}
  &returnFrom=#{wknd_ret_from_day.strftime("%d/%m/%Y")}
  &returnTo=#{wknd_ret_from_day.strftime("%d/%m/%Y")}
  &returndtimefrom=#{hours_ret[:from]}
  &returndtimeto=#{hours_ret[:to]}
  &directFlights=1
  &partner=picky
  &partner_market=eu
  &limit=1"


flights_serialized = open(url).read
flights = JSON.parse(flights_serialized)
flights = flights["data"]
# puts flights

flights.each do |flight|
  flight_formatted = {}
  flight_formatted[:go_date_from]           = DateTime.strptime("#{flight["dTime"]}",'%s') #.strftime("%d/%m/%Y")
  # flight_formatted[:go_date_to]           = DateTime.strptime("#{flight["aTime"]}",'%s')
  flight_formatted[:return_date_from]       = DateTime.strptime("#{flight["route"][1]["dTime"]}",'%s') #.strftime("%d/%m/%Y")
  # flight_formatted[:return_date_to]       = DateTime.strptime("#{flight["route"][1]["aTime"]}",'%s')
  # flight_formatted[:go_flight_number]       = flight["route"][0]["flight_no"]
  # flight_formatted[:return_flight_number]   = flight["route"][1]["flight_no"]
  # flight_formatted[:go_airlines]            = flight["route"][0]["airline"]
  # flight_formatted[:return_airlines]        = flight["route"][1]["airline"]
  flight_formatted[:price]                  = flight["conversion"]["EUR"]
  # flight_formatted[:city_from]            = flight["cityFrom"]
  # flight_formatted[:city_to]              = flight["mapIdto"]
  # flight_formatted[:airport_to]           = flight["flyTo"]
  # flight_formatted[:airport_from]         = flight["flyFrom"]
  # flight_formatted[:country_to]           = flight["countryFrom"]["name"]
  # flight_formatted[:country_from]         = flight["countryTo"]["name"]
  # flight_formatted[:go_airlines]          = flight["airlines"][0]
  flights_formatted << flight_formatted
  puts flight_formatted
end

# Ajoute 7 jours à la date de début et de fin du weekend afin que la boucle cherche pour le weekend d'après.
wknd_dep_from_day = wknd_dep_from_day + 7
wknd_ret_from_day = wknd_ret_from_day + 7
end

request_end = Time.now
puts "#{request_end - request_start} seconds"

# puts flights_formatted
# puts flights_formatted.length
