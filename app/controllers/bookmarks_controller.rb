class BookmarksController < ApplicationController
  def index
    @sorted_options = %w(trier prix destination date)
    wish_list_weekends = current_user.bookmarks

    @wish_list_sorted = []
    if params[:sort_by] == "prix"
      @wish_list_sorted = wish_list_weekends.sort_by {|bookmark| bookmark.weekend["price"] }
    elsif params[:sort_by] == "destination"
      @wish_list_sorted = wish_list_weekends.sort_by {|bookmark| [bookmark.weekend["city_to"].downcase,bookmark.weekend[:go_flight]["dTime"]]}
    else
      @wish_list_sorted = wish_list_weekends.sort_by {|bookmark| bookmark.weekend[:go_flight]["dTime"]}
    end

    # @bookmarks = Bookmark.all
    # iterate over bookmarks
    # get bookmark.weekends
    # @wish_list_weekends = # array de tous les weekends
    @wish_list_weekends = current_user.bookmarks
    #@shared_bookmarks = Bookmark.joins(:list_users).where(list_users: { user_id: current_user.id })
  end

  def create
    go_flight_serialized = weekend_params_serialized[:go_flight]
    go_flight_hash = JSON.parse(go_flight_serialized)

    return_flight_serialized = weekend_params_serialized[:return_flight]
    return_flight_hash = JSON.parse(return_flight_serialized)

    city_from           = weekend_params_serialized[:city_from]
    country_from        = weekend_params_serialized[:country_from]
    city_to             = weekend_params_serialized[:city_to]
    country_to          = weekend_params_serialized[:country_to]
    price               = weekend_params_serialized[:price]
    booking_token       = weekend_params_serialized[:booking_token]
    booking_link        = weekend_params_serialized[:booking_link]
    passenger_number    = weekend_params_serialized[:passenger_number]



    # construction de params adaptées à la table weekend => symbole + HASH go_flight & return_flight
    weekend_params = {
      city_from: city_from,
      country_from: country_from,
      city_to: city_to,
      country_to: country_to,
      price: price,
      booking_token: booking_token,
      booking_link: booking_link,
      passenger_number: passenger_number
    }

    weekend_params[:go_flight]      = go_flight_hash
    weekend_params[:return_flight]  = return_flight_hash

    # Conversion en time des aTime & dTime stockées en string
    weekend_params[:go_flight]["aTime"]     = Time.parse(weekend_params[:go_flight]["aTime"])
    weekend_params[:go_flight]["dTime"]     = Time.parse(weekend_params[:go_flight]["dTime"])
    weekend_params[:return_flight]["aTime"] = Time.parse(weekend_params[:return_flight]["aTime"])
    weekend_params[:return_flight]["dTime"] = Time.parse(weekend_params[:return_flight]["dTime"])

    # binding.pry
    weekend = Weekend.new(weekend_params)

    weekend.save
    @bookmark = Bookmark.new
    # associer le weekend au bookmark
    @bookmark.weekend = weekend


    # associer le user au bookmark
    @bookmark.user = current_user
    @bookmark.save
    # redirection vers l'index des bookmarks => la fameuse wish list
    redirect_to bookmarks_path
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to bookmarks_path
  end

  private

  def weekend_params_serialized
    params.require(:bookmark).permit(:city_from, :country_from, :city_to, :country_to, :price, :booking_token, :booking_link, :go_flight, :return_flight, :passenger_number)
  end
end
