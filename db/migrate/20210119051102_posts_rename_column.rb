class PostsRenameColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :language, :image
    remove_column :posts, :function, :string
    add_column :posts, :url, :text
  end
end
