require 'rspec'
require 'game'
require 'deck'
require 'cards'
require 'player'
require 'hand'

describe Card do
  let(:card){Card.new(10,:heart)}
  it "card initialize sets card value array" do
    expect(card.value_suit).to eq([10, :heart])
  end
end

describe Deck do
  let(:deck){ Deck.new() }

  it "it initializes to size 52" do
    expect(deck.cards.length).to be(52)
  end

  it "shuffles deck" do
    deck.my_shuffle!
    expect(deck.cards).to_not eq(deck.cards.sort {|a,b| a.value <=> b.value})
  end
end

describe Hand do
  let(:hand) { Hand.new }

  # it "initilizes with length of 5" do
  #   expect(hand.array.length).to be(5)
  # end

  it "ranks a high_card correctly" do
    array = [
      Card.new(10, :spade),
      Card.new(9, :heart),
      Card.new(7, :spade),
      Card.new(3, :spade),
      Card.new(2, :spade)
    ]
    pair = Hand.new(array)
    expect(pair.return_hand_ranking).to be(10)
  end

  it "checks for a pair and checks card ranking correctly" do
    array = [
      Card.new(13, :spade),
      Card.new(13, :heart),
      Card.new(7, :spade),
      Card.new(3, :spade),
      Card.new(2, :spade)
    ]
    pair = Hand.new(array)
    expect(pair.return_hand_ranking).to be(26)
  end
end






# describe Player do
#  let(:player) { Player.new("Joe") }
#
#  it "initilizes with a name" do
#    exppect(player.name).to eq("Joe")
#  end
# end

# describe Game do
#  let(:poker) { Game.new([]) }
#
#
#
#
#   end
# end
