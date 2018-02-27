class WeekendsController < ApplicationController

  def index
    skip_before_action :authenticate_user!
    @response = Wknd::ApiResponse.new("Friday")
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

