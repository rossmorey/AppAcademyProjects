require_relative "cards"

class Hand

HIERARCHY = [:straight_flush, :four_of_a_kind, :full_house, :flush, :straight, :three_of_a_kind, :double_pair, :pair_value, :high_card]

  attr_accessor :array

  def initialize(array = [])
    @array = array
  end

  def return_hand_ranking
    HIERARCHY.each do |hand|
      rank = send(hand)
      return rank if rank
    end
  end

  def high_card()
    highest_card = nil
    @array.each do |card|
      if highest_card.nil? || card.value > highest_card.value
        highest_card = card
      end
    end
    highest_card.value
  end

  def pair_value()
    return_value = nil
    @array.each_with_index do |card1|
      @array.each_with_index do |card2|
        if card1 != card2 && card1.value == card2.value
          return_value = card2.value if return_value.nil? || return_value < card2.value
        end
      end
    end
    return nil if return_value.nil?
    return_value + 13
  end

  def double_pair()
    #temp_array = @array.dup
    pair_values = []
    13.downto(1).each do |value|
      count = array.select{|card| card.value == value}
      pair_values << value if count.length > 1
    end
    if pair_values.length == 2
      return pair_values.sort.last + 26
    end
    nil
  end

  def three_of_a_kind()
    13.downto(1).each do |value|
      count = @array.select{|card| card.value == value}
      return value + 39 if count.length > 2
    end
    nil
  end

  def straight()
    nil
  end

  def flush()
    nil
  end

  def full_house()
    nil
  end

  def straight_flush()
    nil
  end


  def four_of_a_kind()
    13.downto(1).each do |value|
      count = @array.select{|card| card.value == value}
      return value + 101 if count.length > 3
    end
    nil
  end



end
