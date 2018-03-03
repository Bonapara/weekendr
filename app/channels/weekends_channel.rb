class WeekendsChannel < ApplicationCable::Channel

  def subscribed
    # A individualiser pour eviter les conflits lors de deux recherches simultanees
    # p params
    stream_from "weekends"
    puts "Connected !!!!"
  end

end
