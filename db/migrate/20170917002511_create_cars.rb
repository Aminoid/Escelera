class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :manufacturer
      t.string :number
      t.string :rate
      t.string :style
      t.string :location
      t.string :status
      t.timestamps
    end
  end
end
