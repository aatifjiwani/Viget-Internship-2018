class AddConstraintsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, [:username, :email], unique: true
    change_column_null :users, :username, false
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
  end
end
