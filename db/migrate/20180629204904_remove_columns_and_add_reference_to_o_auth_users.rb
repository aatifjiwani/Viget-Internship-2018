class RemoveColumnsAndAddReferenceToOAuthUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :o_auth_users, :username
    remove_column :o_auth_users, :email
    add_reference :o_auth_users, :user, foreign_key: true
  end
end
