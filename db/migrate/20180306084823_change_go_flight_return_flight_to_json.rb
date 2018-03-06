class ChangeGoFlightReturnFlightToJson < ActiveRecord::Migration[5.1]
  def change
    remove_column :weekends, :go_flight
    remove_column :weekends, :return_flight
    add_column :weekends, :go_flight, :jsonb
    add_column :weekends, :return_flight, :jsonb
  end
end
