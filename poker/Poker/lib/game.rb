class Game
  def initialize(players)
    @players = players
  end
  def play
    new_Deck
    @players.each do | player |
      player.hand += new_hand
    end
    @players.each do |player|
      current_players << player if player.bet?(current_bet)
    end
  end
  def new_Deck
    @deck = Deck.new()
  end
  def new_hand()
    draw_cards(5)
  end
  def draw_cards(number_of_cards)
    return_array = []
    number_of_cards.times do |number|
      return_array<< @deck.pop
    end
  end


end
