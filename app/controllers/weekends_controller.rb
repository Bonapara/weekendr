class WeekendsController < ApplicationController

  # after_action :display_weekends, only: [:index]

  def index
    # Renvoi vers initialize de api_response.rb
    WeekendJob.perform_now
    # @response = Wknd::ApiResponse.new(
    # "Friday", # Jour aller
    # "Sunday", # Jour retour
    # {from: "18%3A00",to: "23%3A59"}, # Range heures aller
    # {from: "18%3A00",to: "23%3A59"}, # Range heures retour
    # "#{params[:code_from]}", # From
    # "#{params[:code_to]}") # To
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

