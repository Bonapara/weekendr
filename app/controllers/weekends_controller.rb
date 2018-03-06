class WeekendsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  # after_action :display_weekends, only: [:index]

  def index
    @go_days = %w(Vendredi Samedi)
    @return_days = %w(Dimanche Lundi)
    @format = params[:format]
    @code_from = params[:code_from]
    @code_to = params[:code_to]

    # go day
    # button Go day
    if params[:go_day]
      if params[:go_day] == 'Vendredi'
        @go_day = 'Friday'
      else
        @go_day = 'Saturday'
      end
    else
      @go_day = "Friday"
    end

    # return day
    # button Return day
    if params[:return_day]
      if params[:go_day] == 'Dimanche'
        @return_day = 'Sunday'
      else
        @return_day = 'Monday'
      end
    else
      @return_day = "Sunday"
    end

    # go time slide
    # from
    # params de l'index vs params de la home attention attention
    if params[:go_time_from]
      # initialisation curseur @go_time_from_minutes
      @go_time_from_minutes = (Time.strptime(params[:go_time_from], "%I:%M %p").hour * 60)
      # requête URL
      @go_time_from = Time.strptime(params[:go_time_from], "%I:%M %p").strftime("%H:%M")
    else
      @go_time_from_minutes = 1080
      @go_time_from = "18%3A00"
    end
    # to
    if params[:go_time_to]
      @go_time_to_minutes = (Time.strptime(params[:go_time_to], "%I:%M %p").hour * 60)
      @go_time_to = Time.strptime(params[:go_time_to], "%I:%M %p").strftime("%H:%M")
    else
      @go_time_to_minutes = 1439
      @go_time_to = "23%3A59"
    end

    # return time slide
    # from
    if params[:return_time_from]
      @return_time_from_minutes = (Time.strptime(params[:return_time_from], "%I:%M %p").hour * 60)
      @return_time_from = Time.strptime(params[:return_time_from], "%I:%M %p").strftime("%H:%M")
    else
      @return_time_from_minutes = 1080
      @return_time_from = "18%3A00"
    end
    # to
    if params[:return_time_to]
      @return_time_to_minutes = (Time.strptime(params[:return_time_to], "%I:%M %p").hour * 60)
      @return_time_to = Time.strptime(params[:return_time_to], "%I:%M %p").strftime("%H:%M")
    else
      @return_time_to_minutes = 1439
      @return_time_to = "23%3A59"
    end




    if params[:format] == "2"
    # Renvoi vers initialize de api_response.rb
      input_attributes = {}
      input_attributes[:go_day]             = @go_day                                       # Jour aller
      input_attributes[:return_day]         = @return_day                                   # Jour retour
      input_attributes[:go_hours_range]     = {from: @go_time_from, to: @go_time_to}        # Range heures retour
      input_attributes[:return_hours_range] = {from: @return_time_from,to: @return_time_to} # Range heures retour
      input_attributes[:city_from]          = @code_from                                    # From
      input_attributes[:city_to]            = @code_to
                                            # To
      WeekendJob.perform_later(input_attributes)
      # response = Wknd::ApiResponse.new(input_attributes)

      # @results = response.wknd_instances_creation
      # render :index

    else

      @go_days = %w(Jeudi Vendredi Samedi)
      @return_days = %w(Dimanche Lundi Mardi)

      # go day
      # button Go day
      if params[:go_day]
        if params[:go_day] == 'Jeudi'
          @god_day = 'Thursday'
        elsif params[:go_day] == 'Vendredi'
          @go_day = 'Friday'
        else
          @go_day = 'Saturday'
        end
      else
        @go_day = "Thursday"
      end

      # return day
      # button Return day
      if params[:return_day]
        if params[:go_day] == 'Dimanche'
          @return_day = 'Sunday'
        elsif params[:go_day] == 'Lundi'
          @return_day = 'Monday'
        else
          @return_day = 'Tuesday'
        end
      else
        @return_day = "Sunday"
      end

      input_attributes = {}
      input_attributes[:go_day]             = @go_day                                       # Jour aller
      input_attributes[:return_day]         = @return_day                                   # Jour retour
      input_attributes[:go_hours_range]     = {from: @go_time_from, to: @go_time_to}        # Range heures retour
      input_attributes[:return_hours_range] = {from: @return_time_from,to: @return_time_to} # Range heures retour
      input_attributes[:city_from]          = @code_from                                    # From
      input_attributes[:city_to]            = @code_to
                                            # To
      WeekendJob.perform_later(input_attributes)
    end

    response = Wknd::ApiResponse.new(input_attributes)
    @go_date = response.go_date
    @return_date = response.return_date
  end

  private

    def display_weekends
      WeekendJob.perform_now
    end

   def weekend_params
    params.require(:weekend).permit(:code_from, :code_to)
  end
end

