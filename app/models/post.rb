class Post < ApplicationRecord
  belongs_to :user
  has_many :stocks
  has_many :stocked_user, through: :stocks, source: :user, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  validates :user_id, presence: true
  validates :name, presence: true
  validates :content, presence: true, length:{maximum:500}
  validates :point, length:{maximum:500}
  validates :function, presence: true
  validates :language, presence: true
  validates :period, presence: true


  #投稿をストックする
  def stock(user)
    Stock.create(user_id: user.id)
  end

  #ストックをやめる
  def unstock(user)
    Stock.find_by(user_id: user.id).destroy
  end

  #現在のユーザーがいいねしてたらtrueを返す
  def stock?(user)
    stock_users.include?(user)
  end

  #紐づいているタグを全て取得する
  def save_tag(sent_tag)
    if unless self.tags.nil?
      current_tag = self.tags.pluck(:tag_name)
    end
    old_tags = current_tag - sent_tag
    new_tags = sent_tag - current_tag

    old_tags.each do |old_name|
      self.tags.delete 
      Tag.find_by(tag_name: old_name)
    end
    
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << post_tag
    end
  end
end
end
