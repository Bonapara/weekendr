class WeekendsChannel < ApplicationCable::Channel

  def subscribed
    # A individualiser pour eviter les conflits lors de deux recherches simultanees
    stream_from "weekends"
    puts "Connected !!!!"
  end

end
