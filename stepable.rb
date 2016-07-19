module Stepable
  KING_SHIFT = [ [0, -1], [ -1, 0 ], [0, 1], [1, 0],
    [-1, -1], [-1, 1], [1, 1], [1, -1]  ]

  KNIGHT_SHIFT = [ [1, -2], [2, -1], [2, 1], [1, 2], [-1, 2],
    [-2, 1], [-2, -1], [-1, -2] ]

    def moves()
      moves = []
      moves.concat(king_diffs) if move_diffs.include?(:king)
      moves.concat(knight_diffs) if move_diffs.include?(:knight)
      moves
    end

    def king_diffs
      moves = []
      x, y = position

      KING_SHIFT.each do |shift|
        moves << [shift.first + x, shift.last + y]
      end
      moves.select{ |pos| valid_move?(pos) }
    end

    def knight_diffs
      moves = []
      x, y = position

      KNIGHT_SHIFT.each do |shift|
        moves << [shift.first + x, shift.last + y]
      end
      moves.select{ |pos| valid_move?(pos) }
    end

end
