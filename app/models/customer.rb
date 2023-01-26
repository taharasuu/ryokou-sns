class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

#コメント機能・いいね・行ってみたい
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :goods
  has_many :gos

  def good_find(post_id)
    goods.where(post_id: post_id).exists?
  end

  def go_find(post_id)
    gos.where(post_id: post_id).exists?
  end

#フォロー機能
  # フォローをした、されたの関係
  has_many :follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :followeds, through: :follows, source: :followed
  has_many :followers, through: :reverse_of_follows, source: :follower

  #フォローしたときの処理
  def followed(customer_id)
    # binding.pry
    follows.create(followed_id: customer_id)
  end
  # フォローを外すときの処理
  def unfollow(customer_id)
    follows.find_by(followed_id: customer_id).destroy
  end
  # フォローしているか判定
  def followed?(customer)
    followeds.include?(customer)
  end


#ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end


#ユーザー検索機能
  def self.search(keyword)
    where(["last_name like? OR first_name like? OR user_name like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

end
