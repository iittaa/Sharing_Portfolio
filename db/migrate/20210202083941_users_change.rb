class UsersChange < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitter_link, :text
    add_column :users, :github_link, :text
  end
end
