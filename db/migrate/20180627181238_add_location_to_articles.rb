class AddLocationToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :location, :json
  end
end
