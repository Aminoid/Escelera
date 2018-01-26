class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.datetime :return_time
      t.datetime :pickup_time

      t.references :user, :car
      t.timestamps
    end
  end
end
