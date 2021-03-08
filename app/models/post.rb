class Post < ApplicationRecord
  # ----- アソシエーション ------------------------------------------------
  belongs_to :user
  has_many :stocks, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # ----- バリデーション --------------------------------------------------
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :point, length: { maximum: 500 }
  VALID_URL_REGEX = /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  validates :url, presence: true, format: { with: VALID_URL_REGEX }
  validates :period, presence: true
  default_scope -> { order(created_at: :desc) }

  # ----- Gem関連 ---------------------------------------------------------
  mount_uploader :image, ImageUploader

  # ----- メソッド --------------------------------------------------------
  # 投稿をストックする
  def stock(user)
    Stock.create(user_id: user.id)
  end

  # ストックをやめる
  def unstock(user)
    Stock.find_by(user_id: user.id).destroy
  end

  # 紐づいているタグを全て取得する
  def save_tag(sent_tag)
    current_tag = tags.pluck(:tag_name) unless tags.nil?
    old_tags = current_tag - sent_tag
    new_tags = sent_tag - current_tag

    old_tags.each do |old_name|
      tags.delete Tag.find_by(tag_name: old_name)
    end

    new_tags.uniq.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name: new_name)
      tags << post_tag
    end
  end

  # いいね通知作成メソッド
  def create_notification_like!(current_user)
    # 既にいいねされているかの確認
    temp = Notification.where(
      visitor_id: current_user.id,
      visited_id: user_id,
      post_id: id,
      action: 'like'
    )
    # いいねされていない場合、通知を作成する
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外でコメントしている人を全て取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
