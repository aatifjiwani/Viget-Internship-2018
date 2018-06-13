class FixColumnNameToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :encrypted_password, :password_digest
    remove_column :users, :salt, :string
  end
end
