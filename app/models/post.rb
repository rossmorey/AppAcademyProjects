class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  # validates :post_subs, presence: true

  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "User"

end
