class WeekendJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    8.times do
      sleep(1)
      ActionCable.server.broadcast("weekends", {content: "Weekend"})
      puts "tttteestt"
      p ActionCable.server
    end
  end
end
