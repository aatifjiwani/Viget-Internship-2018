class AddLocationColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :location, :json
  end
end
