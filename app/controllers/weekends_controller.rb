class WeekendsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index

    @format = params[:format]
    @code_from = params[:from]
    @code_to = params[:to]

    if params[:go_time_from]
      @go_time_from_minutes = (Time.strptime(params[:go_time_from], "%I:%M %p").hour * 60)
      @go_time_from = Time.strptime(params[:go_time_from], "%I:%M %p").strftime("%H:%M")
    else
      @go_time_from = "16%3A00"
    end

    # needed to initialize filter
    if params[:go_time_to]
      @go_time_to = Time.strptime(params[:go_time_to], "%I:%M %p").strftime("%H:%M")
    else
      @go_time_to = "23%3A59"
    end

    if params[:format] == "2"
      @results = []
    # Renvoi vers initialize de api_response.rb
      response = Wknd::ApiResponse.new(
      "Friday", # Jour aller
      "Sunday", # Jour retour
      {from: @go_time_from, to: @go_time_to},
      {from: "18%3A00",to: "23%3A59"}, # Range heures retour
      @code_from, # From
      @code_to) # To
      @results = response.wknd_instances_creation
      render :index


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

   def weekend_params
    params.require(:weekend).permit(:code_from, :code_to)
  end
end

