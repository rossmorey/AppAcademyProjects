class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: "User"

    has_many :post_subs, inverse_of: :sub
    has_many :posts, through: :post_subs
end
