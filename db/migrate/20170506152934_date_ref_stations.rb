class DateRefStations < ActiveRecord::Migration[5.0]
  def change
    rename_table :date_ref_id, :date_refs
  end
end
