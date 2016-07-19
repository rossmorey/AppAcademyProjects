require_relative 'slideable.rb'
require_relative 'stepable.rb'
require 'byebug'
class Piece
  attr_accessor :color, :board, :position

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def position_on_board?(pos)
    x, y = pos
    return true if x.between?(0, 7) && y.between?(0, 7)
    false
  end

  def empty?
    return false
  end

  def to_s
    " #{symbol.to_s} "
  end

  def valid_moves
    moves
  end

  def valid_move?(pos)
    return false unless position_on_board?(pos) #return false if it's not on the board
    result = true
    unless @board[pos].empty?
      result = false
      result = true if capturable?(pos)
    end
    result
  end

  def capturable?(pos)
    return true if @board[pos].color != self.color
    false
  end

end

class Rook < Piece
  include Slideable

  def symbol
    :♜
  end

  protected
  def move_dirs
    [:horizontal]
  end
end

class Bishop < Piece
  include Slideable

  def symbol
    :♝
  end

  protected
  def move_dirs
    [:diagonal]
  end
end

class Queen < Piece
  include Slideable

  def symbol
    :♛
  end

  protected
  def move_dirs
    [:diagonal, :horizontal]
  end
end
class Knight < Piece
  include Stepable

  def symbol
    :♞
  end

  protected
  def move_diffs
    [:knight]
  end
end
class King < Piece
  include Stepable

  def symbol
    :♚
  end

  protected
  def move_diffs
  [:king]
  end
end
class Pawn < Piece
  def symbol
    :♟
  end

  def moves
    moves = []
    moves.concat(forward_steps)
    moves.concat(side_attacks)
    # debugger
    moves
  end

  def forward_directions
    color == :white ? [1, 0] : [-1, 0]
  end

  def forward_steps
    # debugger
    x, y = position
    moves = []
    first_move = [forward_directions.first + x, forward_directions.last + y]
    moves << first_move if pawn_valid_move?(first_move)
    # debugger
    if at_start_row? && !moves.empty?
      second_move = [moves[0][0] + forward_directions[0], moves[0].last + forward_directions.last]
      moves << second_move if pawn_valid_move?(second_move)
    end
    moves
  end

  def side_attacks
    x, y = position
    moves = []
    sides = color == :white ? [[-1, 1], [1, 1]] : [[-1, -1], [1, -1]]
    sides.each{|pos| moves << [pos.first + x, pos.last + y] }
    moves.select{ |pos| position_on_board?(pos) && ( !board[pos].empty? && capturable?(pos)) }
    # lets test the above line for bugs
  end

  def pawn_valid_move?(pos)
    return false unless position_on_board?(pos) #return false if it's not on the board
    return false unless board[pos].empty?
    true
  end

  def at_start_row?
    return true if position.first == 6 || position.first == 1
    false
  end


end
