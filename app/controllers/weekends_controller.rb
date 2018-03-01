class WeekendsController < ApplicationController

  def index

    if params[:format] == "2"
    # Renvoi vers initialize de api_response.rb
      @response = Wknd::ApiResponse.new(
      "Thursday", # Jour aller
      "Sunday", # Jour retour
      {from: "18%3A00",to: "23%3A59"}, # Range heures aller
      {from: "18%3A00",to: "23%3A59"}, # Range heures retour
      "#{params[:code_from]}", # From
      "#{params[:code_to]}") # To

    else

      @response = Wknd::ApiResponse.new(
      "Thursday", # Jour aller
      "Sunday", # Jour retour
      {from: "18%3A00",to: "23%3A59"}, # Range heures aller
      {from: "18%3A00",to: "23%3A59"}, # Range heures retour
      "#{params[:code_from]}", # From
      "#{params[:code_to]}") # To

    # @response = Wknd::ApiResponse.new(
    # "Friday", # Jour aller
    # "Monday", # Jour retour
    # {from: "18%3A00",to: "23%3A59"}, # Range heures aller
    # {from: "18%3A00",to: "23%3A59"}, # Range heures retour
    # "#{params[:code_from]}", # From
    # "#{params[:code_to]}") # To

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

