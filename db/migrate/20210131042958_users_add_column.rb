class UsersAddColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profile, :text
    add_index :tag_maps, [:post_id, :tag_id], unique: true
  end
end
