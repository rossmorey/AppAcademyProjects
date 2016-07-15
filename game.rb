require_relative 'board'
require_relative 'tile'


class Minesweeper
  def initialize()
    puts "how large do you want your board?"
    size = gets.chomp.to_i
    puts "how hard do you want the game to be, e.g. 1 (easy) or 10 (hard)"
    level = gets.chomp.to_i
    @board = Board.new(size, level)
    @start_time = Time.new
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
    when :save
      @board.board_export_yaml
    when :load
      @board.board_load_yaml
    end
  end

  def run
    until @board.won?
      if play_turn == "BOOM!"
        system('say "you lose"')
        puts "you lose!"
        puts "it took you"
        puts time_elapsed.to_s + " seconds"
        puts "to lose "
        return "loser"

      end
    end
    puts "you won!"
    system('say "you win"')
    puts "it took you"
    puts time_elapsed.to_s + " seconds"
    puts "to win"
  end

  def time_elapsed
    Time.new - @start_time
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
