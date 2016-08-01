class User < ActiveRecord::Base
  validates :username, uniqueness: true, presence: true
  has_many(
  :contacts,
  foreign_key: user_id,
  class_name:'Contact'
  )
end
