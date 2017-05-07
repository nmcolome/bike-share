class ChangeDateIdName < ActiveRecord::Migration[5.0]
  def change
    rename_column :stations, :the_date_id, :date_ref_id
  end
end
