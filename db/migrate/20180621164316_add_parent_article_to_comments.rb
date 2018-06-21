class AddParentArticleToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :parent_article, :integer
  end
end
