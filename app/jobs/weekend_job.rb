class WeekendJob < ApplicationJob
  queue_as :default

  def perform (from, to)
    response = Wknd::ApiResponse.new(
      "Friday", # Jour aller
      "Sunday", # Jour retour
      {from: "18%3A00",to: "23%3A59"}, # Range heures aller
      {from: "18%3A00",to: "23%3A59"}, # Range heures retour
      from, # From
      to)

    4.times do
      sleep(1)
      # ActionCable.server.broadcast("weekends", {content: response.call} )
      # weekend_card = render 'shared/we_card', weekend: response.call
      weekend_card = "<h1> #{response.call[:return_flight][:airport_from]} </h1>"
      # weekend_card = "<h1> test </h1>"
      ActionCable.server.broadcast("weekends", {content: weekend_card} )
      # ActionCable.server.broadcast("weekends", {content: weekend_card } )
    end
      #     go_date = go_date + 7
      # return_date = return_date + 7
      #       go_date = date_of_next(@go_day)
      # return_date = date_of_next(@return_day)
  end
end
