class AddConstraintsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    change_column_null :users, :username, false
    change_column_null :users, :email, false
  end
end
