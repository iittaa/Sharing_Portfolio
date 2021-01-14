class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.text :content
      t.text :point
      t.string :function
      t.string :language
      t.string :period
      
      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end




class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, foreign_key: true
      
      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
