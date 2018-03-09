class AddPassengerToWeekend < ActiveRecord::Migration[5.1]
  def change
    add_column :weekends, :passenger_number, :integer
  end
end
