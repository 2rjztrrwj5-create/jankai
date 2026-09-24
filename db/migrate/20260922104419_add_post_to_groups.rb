class AddPostToGroups < ActiveRecord::Migration[8.0]
  def change
    add_reference :groups, :post, null: false, foreign_key: true
  end
end
