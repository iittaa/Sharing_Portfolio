class Post < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :name, presence: true
  validates :content, presence: true, length:{maximum:500}
  validates :point, length:{maximum:500}
  validates :function, presence: true
  validates :language, presence: true
  validates :period, presence: true
end
