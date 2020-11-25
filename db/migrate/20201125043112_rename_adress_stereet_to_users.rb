class RenameAdressStereetToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :adress_stereet, :address_street
    rename_column :users, :adress_building, :address_building
  end
end
