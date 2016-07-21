class TowerOfHanoi
  #attr_accessor :tower1,:tower2, :tower3
  attr_accessor :towers
  def initialize(tower1 = [3,2,1],tower2 = [] ,tower3 = [])
    @towers = [tower1, tower2, tower3]
  end
  def move(start_pos, end_pos)
    if @towers[end_pos].empty? || @towers[end_pos].last > @towers[start_pos].last
      @towers[end_pos] << @towers[start_pos].pop
    end
  end
  def won?
    p @towers[2]
    @towers[2] == [3,2,1]
  end
end
