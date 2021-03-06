class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter github]

  # ----- attr_accessorメソッド -------------------------------------------
  # attr_accessor :password, :password_confirmation,:remember_token, :reset_token

  # ----- アソシエーション ------------------------------------------------
  has_many :posts, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :stock_posts, through: :stocks, source: :post

  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  has_many :comments, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy  # 自分からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy # 相手からの通知

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries

  # ----- バリデーション --------------------------------------------------
  validates :name, presence: true, length: { maximum: 50 }
  VALID_URL_REGEX = /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/.freeze
  validates :twitter_link, format: { with: VALID_URL_REGEX }, allow_blank: true
  validates :github_link, format: { with: VALID_URL_REGEX }, allow_blank: true
  validates :profile, length: { maximum: 500 }

  # validates :email, presence: true, uniqueness: true
  # VALID_PASS_REGEX = /\A[a-zA-Z0-9]+\z/
  # validates :password, presence: true, unless: :uid?, length: {minimum: 6}, format: { with: VALID_PASS_REGEX }, confirmation: true
  # has_secure_password validations: false

  # ----- 画像関連 --------------------------------------------------------
  mount_uploader :user_image, ImageUploader

  # ----- メソッド --------------------------------------------------------

  # フォローしているかを確認するメソッド
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  # フォローするときのメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  # フォローを外すときのメソッド
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  # SNS認証での新規登録またはログイン
  def self.find_for_oauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)

    user ||= User.create!(
      uid: auth.uid,
      provider: auth.provider,
      name: auth[:info][:name],
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20],
      profile: auth[:info][:description],
      twitter_link: auth[:info][:urls][:Twitter],
      github_link: auth[:info][:urls][:GitHub],
      remote_user_image_url: auth[:info][:image]
    )
  end

  def self.dummy_email(auth)
    "#{Time.now.strftime('%Y%m%d%H%M%S').to_i}-#{auth.uid}-#{auth.provider}@example.com"
  end

  # ユーザーがすでにストックしているか確認する
  def stock?(post)
    stocks.exists?(post_id: post.id)
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  # フォローの通知生成メソッド
  def create_notification_follow!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # ----- 不要コード ------------------------------------------------------

  # 与えられた文字列のハッシュ値を返す
  # def self.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end

  # passwordをハッシュ化させる
  # def password_hash
  #   update_attribute(:password_digest, User.digest(password))
  # end

  # ランダムな文字列を生成する
  # def self.new_token
  #   SecureRandom.urlsafe_base64
  # end

  # ランダムな文字列をremember_tokenカラムに追加し、remember_digestカラムにそれを暗号化して追加する
  # def remember
  #   self.remember_token = User.new_token
  #   update_attribute(:remember_digest, User.digest(remember_token))
  # end

  # def forget
  #   update_attribute(:remember_digest, nil)
  # end

  # BCrypt::Password.new(remember_digest)はハッシュ化を解いた値を意味する
  # is_password?はイコールと同じ？
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
