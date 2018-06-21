class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :article, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :value
      t.timestamps
    end
    
    add_index :votes, [:article_id, :user_id], unique: true

  end
end
