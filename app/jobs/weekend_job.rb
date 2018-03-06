class WeekendJob < ApplicationJob
  queue_as :default

  def perform ( attributes = {} )
    response = Wknd::ApiResponse.new(attributes)
    go_date = response.go_date
    return_date = response.return_date


    12.times do
      @weekend = response.call_date(go_date, return_date)
      weekend_card = ApplicationController.renderer.render(partial: "shared/weekendcard", locals: { weekend: @weekend })
      ActionCable.server.broadcast("weekends", { content: weekend_card } )
      go_date = go_date + 7
      return_date = return_date + 7
    end

  end
end
