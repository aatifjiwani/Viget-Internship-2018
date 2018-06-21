class AddVoteToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :vote, :integer, default: 0, null: false
  end
end
