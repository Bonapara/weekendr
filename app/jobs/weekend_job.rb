class WeekendJob < ApplicationJob
  queue_as :default

  def perform ( attributes = {}, request_id, user_id )
    response = Wknd::ApiResponse.new(attributes)
    # On initialise les dates de départ et de retour
    go_date = response.go_date
    return_date = response.return_date
    @num_passenger = attributes[:num_passenger]
    # On attend 1 sec pour etre sur que le DOM est chargé (à modifier)
    sleep(2)

    # On appelle l'API 12 fois
    12.times do
      @weekend = response.call_date(go_date, return_date)
      # Si elle repond, on envoie la card sinon on envoie la card no_results
      if @weekend == {}
        weekend_card = ApplicationController.renderer.render(partial: "shared/no_results_card")
      else
        weekend_card = ApplicationController.renderer.render(partial: "shared/weekendcard", locals: { weekend: @weekend, num_passenger: @num_passenger, user_id: user_id})
      end
      # On envoie la weekend card sur le channel associé à la request
      ActionCable.server.broadcast("weekends_#{request_id}", { content: weekend_card } )
      # On passe au prochain weekend
      go_date = go_date + 7
      return_date = return_date + 7
    end

  end
end
