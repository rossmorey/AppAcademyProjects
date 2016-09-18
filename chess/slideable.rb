module Slideable
  HORIZONTAL_SHIFT = [ [0, -1], [ -1, 0 ], [0, 1], [1, 0] ]
  DIAGONAL_SHIFT = [ [-1, -1], [-1, 1], [1, 1], [1, -1]  ]

  def moves()
    moves = []
    moves.concat(horizontal_dirs) if move_dirs.include?(:horizontal)
    moves.concat(diagonal_dirs) if move_dirs.include?(:diagonal)
    moves
  end

  def horizontal_dirs
    horizontals = []
    x, y = position

    HORIZONTAL_SHIFT.each do |shift|
      horizontals.concat(grow_unblocked_moves_in_dir(position, shift))
    end
    horizontals
  end

  def diagonal_dirs
    diagonals = []
    x, y = position

    DIAGONAL_SHIFT.each do |shift|
      diagonals.concat(grow_unblocked_moves_in_dir(position, shift))
    end
    diagonals
  end


  def grow_unblocked_moves_in_dir(pos, shift)
    moves = []
    current = [pos.first + shift.first, pos.last + shift.last]
    while valid_move?(current)
      moves << current
      break if !board[current].empty? && capturable?(current)
      current = [current.first + shift.first, current.last + shift.last]
    end
    moves
  end

end
