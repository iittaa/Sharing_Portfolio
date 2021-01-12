class User < ApplicationRecord
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: {maximum: 100}, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: {minimum: 6}
  

  has_secure_password

end
