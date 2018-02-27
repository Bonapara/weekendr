class CreateWeekends < ActiveRecord::Migration[5.1]
  def change
    create_table :weekends do |t|
      t.string :city_from
      t.string :country_from
      t.string :city_to
      t.string :country_to
      t.integer :price
      t.text :booking_token
      t.text :booking_link
      t.text :go_flight
      t.text :return_flight

      t.timestamps
    end
  end
end
