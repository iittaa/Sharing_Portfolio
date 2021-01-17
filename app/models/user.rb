class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :stocked_post, through: :stocks, source: :post

  attr_accessor :remember_token, :reset_token

  validates :name, presence: true, unless: :uid?
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, unless: :uid?, uniqueness: true, length: {maximum: 100}, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, unless: :uid?, length: {minimum: 6}, allow_nil: true

  has_secure_password

  #与えられた文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  #ランダムな文字列を生成する
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  #ランダムな文字列をremember_tokenカラムに追加し、remember_digestカラムにそれを暗号化して追加する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  #BCrypt::Password.new(remember_digest)はハッシュ化を解いた値を意味する
  #is_password?はイコールと同じ？
  def authenticated?(remember_token)
    if remember_digest.nil?
      return false
    else
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end


  #ユーザーがすでにストックしているか確認する
  def stock?(post)
    self.stocks.exists?(post_id: post.id)
  end

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    username = auth[:info][:username]


    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.username = username
    end
  end
end
