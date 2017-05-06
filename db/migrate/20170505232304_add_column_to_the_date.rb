class AddColumnToTheDate < ActiveRecord::Migration[5.0]
  def change
    add_column :the_dates, :name, :text
  end
end
