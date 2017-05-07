class ChangeDateName < ActiveRecord::Migration[5.0]
  def change
    rename_table :the_dates, :date_ref_id
 
  end
end
