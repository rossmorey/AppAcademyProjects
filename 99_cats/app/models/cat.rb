# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  COLORS = ['white', 'black', 'red', 'spots']
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: ['M', 'F'] }

  has_many :cat_rental_requests, dependent: :destroy

  def age
    result = Date.today.year - self.birth_date.year
    result -= 1 if Date.today.month < self.birth_date.month || (Date.today.month == self.birth_date.month && Date.today.mday < self.birth_date.mday)
    result
  end



end
