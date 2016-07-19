require_relative 'slideable.rb'
require_relative 'stepable.rb'
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

  # def moves
  #
  # end
end

class Rook < Piece
  include Slideable

  attr_reader :move_dirs

  def symbol
    :R
  end

  protected
  def move_dirs
    [:horizontal]
  end
end

class Bishop < Piece
  include Slideable

  attr_reader :move_dirs

  def symbol
    :B
  end

  protected
  def move_dirs
    [:diagonal]
  end
end

class Queen < Piece
  include Slideable

  attr_reader :move_dirs

  def symbol
    :Q
  end

  protected
  def move_dirs
    [:diagonal, :horizontal]
  end
end
class Knight < Piece
  include Stepable

  attr_reader :move_dirs

  def symbol
    :N
  end

  protected
  def move_diffs
    # !!!
  end
end
class King < Piece
  include Stepable

  attr_reader :move_dirs

  def symbol
    :K
  end

  protected
  def move_diffs
    # !!!
  end
end
class Pawn < Piece
  def symbol
    :P
  end


end
