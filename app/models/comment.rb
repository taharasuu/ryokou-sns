class Comment < ApplicationRecord

#コメント機能
  belongs_to :customer
  belongs_to :post

end
