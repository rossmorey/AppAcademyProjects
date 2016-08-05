class Sub < ActiveRecord::Base
  validates :titile, :description, :moderator_id, presence: true
  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: "User"

  has_many :posts
end
