CARD_VALUES = [:heart => "♡", :club => "♧", :diamond => "♢", :spade => "♤" ]

class Card
  attr_reader :value, :suit, :value_suit
  def initialize(value, suit)
    @value = value
    @suit = suit
    @value_suit = [value, suit]
  end

  def to_s
    " #{suit} #{CARD_VALUE[value]} "
  end



end
