class DropNameColumnFromDate < ActiveRecord::Migration[5.0]
  def change
    remove_column :date_refs, :name
  end
end
