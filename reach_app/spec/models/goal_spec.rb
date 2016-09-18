require 'rails_helper'

RSpec.describe Goal, type: :model do

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user) }
  end

  describe "associations" do
    it { should belong_to(:user)}
  end

  describe "class methods" do

  end

end
