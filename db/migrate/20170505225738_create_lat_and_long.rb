class CreateLatAndLong < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :lat, :float
    add_column :stations, :long, :float
  end
end
