class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :voteable_id, null: false
      t.string :voteable_type, null: false
      t.references :user, foreign_key: true
      t.integer :value, null:false
      t.timestamps
    end
    
    add_index :votes, [:voteable_id, :voteable_type, :user_id], unique: true

  end
end
