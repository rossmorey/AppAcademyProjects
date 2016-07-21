class Deck
  attr_reader :cards
  SUITS = [:heart,:spade,:diamond,:club]
  def initialize()
    @cards = build
  end

  def build()
    return_array = []
    SUITS.each do |s|
      (1..13).each do |value|
        return_array << Card.new(value,s)
      end
    end
    return_array
  end

  def my_shuffle!
    #p @cards
    @cards = @cards.shuffle
    #p @cards
    #puts @cards.sort {|a,b| a.value <=> b.value}
  end

end
