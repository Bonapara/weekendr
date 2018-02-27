class WeekendsController < ApplicationController

  def index
    # Renvoi vers initialize de api_response.rb
    @response = Wknd::ApiResponse.new(
    "Friday", # Jour aller
    "Sunday", # Jour retour
    {from: "18%3A00",to: "23%3A59"}, # Range heures aller
    {from: "18%3A00",to: "23%3A59"}, # Range heures retour
    "PAR", # From
    "MAD") # To
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
end

