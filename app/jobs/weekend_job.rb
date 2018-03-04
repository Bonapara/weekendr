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

    go_date = response.date_of_next(response.go_day)
    return_date = response.date_of_next(response.return_day)
    if go_date > return_date
      return_date = return_date + 7
    end

    4.times do
      # ActionCable.server.broadcast("weekends", {content: response.call} )
      # weekend_card = render_to_string 'shared/weekendcard' # , weekend: response.call(go_date, return_date)
      # weekend_card = "
      # <div class='col-xs-6 col-sm-3 col-md-2'>
      #   <div class='card'>
      #     <div class='card-header'>
      #       <h1 class='card-title'> #{response.call_date(go_date, return_date)[:go_flight][:dTime].strftime('%d/%m')} - #{response.call_date(go_date, return_date)[:return_flight][:dTime].strftime('%d/%m')} </h1>
      #     </div>
      #   </div>
      # </div>"
      # @weekend = response.call(go_date, return_date)
      sleep(1)
      @weekend = "test magle"
      weekend_card = ApplicationController.renderer.render(partial: "shared/weekendcard", locals: { weekend: @weekend })

      # content = response.call(go_date, return_date)
      # weekend_card = "<h1> test </h1>"
      ActionCable.server.broadcast("weekends", { content: weekend_card } )

      # NEXT WEEKEND
      go_date = go_date + 7
      return_date = return_date + 7
    end

  end
end
