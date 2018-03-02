class WeekendsController < ApplicationController

  # after_action :display_weekends, only: [:index]

  def index



    if params[:format] == "2"
      @results = []
      # Renvoi vers initialize de api_response.rb
      WeekendJob.perform_later
      response = Wknd::ApiResponse.new(
      "Friday", # Jour aller
      "Sunday", # Jour retour
      {from: "18%3A00",to: "23%3A59"}, # Range heures aller
      {from: "18%3A00",to: "23%3A59"}, # Range heures retour
      "#{params[:code_from]}", # From
      "#{params[:code_to]}") # To

      @results = response.wknd_instances_creation




    else

      response1 = Wknd::ApiResponse.new(
      "Thursday", # Jour aller
      "Sunday", # Jour retour
      {from: "18%3A00",to: "23%3A59"}, # Range heures aller
      {from: "18%3A00",to: "23%3A59"}, # Range heures retour
      "#{params[:code_from]}", # From
      "#{params[:code_to]}") # To


      @results = response1.wknd_instances_creation

      ## code pour comparer deux formats de weekends
      ## problème de décalage en raison de la date de réservation jeudi / vendredi
      ## affaire à suivre
      # response2 = Wknd::ApiResponse.new(
      # "Friday", # Jour aller
      # "Monday", # Jour retour
      # {from: "18%3A00",to: "23%3A59"}, # Range heures aller
      # {from: "18%3A00",to: "23%3A59"}, # Range heures retour
      # "#{params[:code_from]}", # From
      # "#{params[:code_to]}") # To

      # results2 = response2.wknd_instances_creation

      # @results = []
      # results1.each_with_index do |weekend1, index1|
      #   if weekend1[:price] > results2[index1][:price]
      #     @results << weekend1
      #   else
      #     @results << results2[index1]
      #   end
      # end
    end
>>>>>>> master
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def display_weekends
      WeekendJob.perform_now
    end

   def weekend_params
    params.require(:weekend).permit(:code_from, :code_to)
  end
end

