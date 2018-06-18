class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_token, :string
    add_index :users, :password_token
  end
end
