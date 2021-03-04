class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # ----- attr_accessorメソッド -------------------------------------------
  # attr_accessor :password, :password_confirmation,:remember_token, :reset_token
  
  
  # ----- アソシエーション ------------------------------------------------
  has_many :posts, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy  #自分からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy #相手からの通知


  
  # ----- バリデーション --------------------------------------------------
  validates :name, presence: true, length: {maximum: 100}
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, unless: :uid?, uniqueness: true, length: {maximum: 100}, format: { with: VALID_EMAIL_REGEX }
  # VALID_PASS_REGEX = /\A[a-zA-Z0-9]+\z/ 
  # validates :password, presence: true, unless: :uid?, length: {minimum: 6}, format: { with: VALID_PASS_REGEX }, confirmation: true
  # validates :profile, length: {maximum: 500}
  # VALID_URL_REGEX = /\A#{URI::regexp(%w(http https))}\z/
  # validates :twitter_link, format: { with: VALID_URL_REGEX }, allow_blank: true
  # validates :github_link, format: { with: VALID_URL_REGEX }, allow_blank: true
  # has_secure_password validations: false


  # ----- Gem関連 ---------------------------------------------------------
  mount_uploader :user_image, ImageUploader 

  # ----- メソッド --------------------------------------------------------

  #ユーザーがすでにストックしているか確認する
  def stock?(post)
    self.stocks.exists?(post_id: post.id)
  end

  
  # ----- 不要コード ------------------------------------------------------
 
 
  #与えられた文字列のハッシュ値を返す
  # def self.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end

  #passwordをハッシュ化させる
  # def password_hash
  #   update_attribute(:password_digest, User.digest(password))
  # end

  #ランダムな文字列を生成する
  # def self.new_token
  #   SecureRandom.urlsafe_base64
  # end

  #ランダムな文字列をremember_tokenカラムに追加し、remember_digestカラムにそれを暗号化して追加する
  # def remember
  #   self.remember_token = User.new_token
  #   update_attribute(:remember_digest, User.digest(remember_token))
  # end

  # def forget
  #   update_attribute(:remember_digest, nil)
  # end

  #BCrypt::Password.new(remember_digest)はハッシュ化を解いた値を意味する
  #is_password?はイコールと同じ？
  # def authenticated?(remember_token)
  #   if remember_digest.nil?
  #     return false
  #   else
  #     BCrypt::Password.new(remember_digest).is_password?(remember_token)
  #   end
  # end

  # def create_reset_digest
  #   self.reset_token = User.new_token
  #   update_attribute(:reset_digest, User.digest(reset_token))
  #   update_attribute(:reset_sent_at, Time.zone.now)
  # end

end
