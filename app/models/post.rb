class Post < ApplicationRecord
  belongs_to :user
  has_many :stocks
  has_many :stock_users, through: :stocks, source: :user
  has_many :stocked_user, through: :stocks, source: :user

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




end
