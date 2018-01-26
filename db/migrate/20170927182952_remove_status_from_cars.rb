class RemoveStatusFromCars < ActiveRecord::Migration[5.0]
  def change
    remove_column :cars, :status
  end
end
