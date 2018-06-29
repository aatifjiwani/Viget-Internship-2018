class RemoveIndexAndAddUniqueIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :o_auth_users, :user_id
    add_index :o_auth_users, :user_id, unique: true
  end
end
