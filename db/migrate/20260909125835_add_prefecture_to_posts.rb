class AddPrefectureToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :prefecture, :string
  end
end
