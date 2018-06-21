class ChangeColumnNullToComments < ActiveRecord::Migration[5.2]
  def change
    change_column_null :comments, :user_id, false
    change_column_null :comments, :body, false
    change_column_null :comments, :commentable_id, false
    change_column_null :comments, :commentable_type, false
    add_index :comments, :user_id
  end
end
