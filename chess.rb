require_relative 'board.rb'
require_relative 'player.rb'

class Game
  attr_accessor :player, :board

  def initialize(board = Board.new, player = nil)
    player ||= Player.new(board)
    @board = board
    @player = player
  end

  def run
    while true
      start_pos = player.move
      piece = board[start_pos]
      end_pos = player.move
      board.move_piece(piece.color, start_pos, end_pos)
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  pl = Player.new(b)
  g = Game.new(b, pl)
  g.run
end
