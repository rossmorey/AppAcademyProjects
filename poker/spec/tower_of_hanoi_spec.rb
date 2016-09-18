require 'rspec'
require 'tower_of_hanoi'


describe TowerOfHanoi do

let(:tower) {TowerOfHanoi.new()}

  describe "#move" do
    it "given valid move, moves block" do
      tower.move(0,1)
      expect(tower.towers[1]).to eq([1])
      expect(tower.towers[0]).to eq([3,2])
    end
    it "given invalid move, doesn't do anything" do
      a_tower = TowerOfHanoi.new([3,2],[1])
      a_tower.move(0,1)
      expect(a_tower.towers[1]).to eq([1])
      expect(a_tower.towers[0]).to eq([3,2])
    end
  end
  describe "#won?" do
    it "returns true if the game is over" do
      win_tower = TowerOfHanoi.new([],[],[3,2,1])
      expect(win_tower.won?).to be(true)
    end
    it "returns false if the game is over" do

      expect(tower.won?).to be(false)
    end
  end



end

  #
  # it "removes duplicates" do
  #     test_array1 = [1,2,1,3,3]
  #     expect(test_array1.my_uniq).to eq([1,2,3])
  #   end
  #
  #   it "given an empty array -> return empty array" do
  #     expect([].my_uniq).to eq([])
  #   end
  #
  #   it " array with no duplicates returns self." do
  #     expect([1,2,3,4,5,6,7,8,9,10]).to eq([1,2,3,4,5,6,7,8,9,10])
  #   end
  # end
