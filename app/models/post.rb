class Post < ApplicationRecord

  has_one_attached :image

#コメント機能・いいね・行ってみたい
  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :goods
  has_many :gos
  has_many :genres

#投稿検索機能
  def self.search(keyword)
    where(["shop like? OR address like?", "%#{keyword}%", "%#{keyword}%"])
  end

end
