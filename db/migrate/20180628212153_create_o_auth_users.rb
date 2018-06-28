class CreateOAuthUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :o_auth_users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :provider, null: false

      t.timestamps
    end
    
    add_index :o_auth_users, [:username, :email, :provider], unique: true
  end
end
