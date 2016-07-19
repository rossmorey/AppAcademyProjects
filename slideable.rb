module Slideable
  HORIZONTAL_SHIFT = [ [0, -1], [ -1, 0 ], [0, 1], [1, 0] ]
  # DIAGONAL_SHIFT = [ [r-1, c-1], [r-1, c+1], [r+1, c+1], [r, c-1]  ]

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
  def capturable?(pos)
    #return false if @board[pos].empty?
    return true if @board[pos].color != self.color
    false

    # HORIZONTAL_SHIFT.each do |arr|
    #   hotizontals << [arr.first + x, arr.last + y]
    # end
    # result = []
    # horizontals.each do |horizontal|
    #   result << grow_unblocked_moves_in_dir(horizontal.first, horizontal.last)
    # end
    # result
  end

  def diagonal_dirs
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

  def valid_move?(pos)
    return false unless position_on_board?(pos) #return false if it's not on the board
    result = true
    unless @board[pos].empty?
      result = false
      result = true if capturable?(pos)
    end
    result
  end

end
