class Piece
  attr_accessor :color, :board, :position

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def to_s
    " #{symbol.to_s} "
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
