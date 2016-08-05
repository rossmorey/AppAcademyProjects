class Post < ActiveRecord::Base
  validates :title, :sub_id, :author_id, presence: true
  belongs_to :sub
  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "User"

end
