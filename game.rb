require_relative 'board'
require_relative 'tile'

class Minesweeper
  def initialize
    @board = Board.new
  end

  def play_turn
    @board.render
    puts "where would like to move?"
    coords = parse_coord(gets.chomp)
    puts "what do you want to do there?"
    puts "r: reveal, f:flag, u:unflag"
    action = parse_action(gets.chomp)
    case action
    when :r
      current_tile = @board[coords]
      if current_tile.is_bomb?
        return "BOOM!"
      else
        @board.chain_reveal(coords)
      end
    when :f
      @board[coords].flag
    when :u
      @board[coords].unflag
    when :debug
      @board.render(true)
    end
  end

  def run
    until @board.won?
      if play_turn == "BOOM!"
        puts "you lose!"
        return "loser"

      end
    end
    puts "you won!"
  end

  def parse_action(string)
    string.downcase.to_sym
  end

  def parse_coord(string)
    array = string.split(",")
    array.map{|x| x.to_i}
  end
end

if __FILE__ == $PROGRAM_NAME
  a = Minesweeper.new
  a.run
end
