class ChangeCommentsToPolymorphic < ActiveRecord::Migration[8.0]
  def change
    rename_column :comments, :post_id, :commentable_id
    add_column :comments, :commentable_type, :string
    Comment.reset_column_information
    Comment.update_all(commentable_type: "Post")
  end
end