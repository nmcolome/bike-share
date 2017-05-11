class ChangeZipToString < ActiveRecord::Migration[5.0]
  def change
    change_column :zipcodes, :zipcode, :varchar
  end
end
