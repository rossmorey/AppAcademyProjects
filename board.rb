require_relative 'null_piece.rb'
require_relative 'piece.rb'

class Board
  attr_accessor :grid

  def initialize(grid = Array.new(8) { Array.new(8) { NullPiece.instance } })
    @grid = grid
    populate
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def move_piece(color, start, end_pos)
    selected_piece = self[start]
    valid_moves = selected_piece.valid_moves
    if valid_moves.include?(end_pos) && !selected_piece.empty?
      self[end_pos] = self[start]
      self[start] = NullPiece.instance

      # self[start], self[end_pos] = self[end_pos], self[start]
      selected_piece.position = end_pos
    end
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def pawn_row(color, row)
    pawn_row = []
    8.times do |idx|
      pawn_row << Pawn.new(color, self, [row, idx])
    end
    pawn_row
  end


  def populate
    @grid[6] = pawn_row(:black, 6)
    @grid[1] = pawn_row(:white, 1)
    other_row(:black, 7)
    other_row(:white, 0)
  end

  def other_row(color, row)
    back_row = [ Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook ]
    back_row = back_row.reverse if color == :black
    back_row.each_with_index do |piece, idx|
      @grid[row][idx] = piece.new(color, self, [row, idx])
    end
  end
  # def populate
  #   color = {:white => 1, :black => 7}
  #   8.times do |idx|
  #     # @grid[color[:white]][idx] = Pawn.new(color, self, [color[:white], idx])
  #     color.each do |k, v|
  #       @grid[color[k]][idx] = Pawn.new(k, self, [color[k], [idx]])
  #     end
  #   end



end
