require_relative 'null_piece.rb'
require_relative 'piece.rb'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize(grid = Array.new(8) { Array.new(8) { NullPiece.instance } })
    @grid = grid
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
    # debugger
    selected_piece = self[start]
    if board.dup.move_piece(color, start, end_pos).in_check?(color)
      Raise "Can't put yourself in check!"
    end
    # return if selected_piece.empty?
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

  def dup
    debugger
    result = Board.new
    current = grid.flatten
    8.times do |idx|
      8.times do |jdx|
        old = current.shift
        if old.class == NullPiece
          result[[idx, jdx]] = NullPiece.instance
        else
          result[[idx, jdx]] = old.class.new(old.color, result, old.position)
        end
      end
    end
    result
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

  def in_check?(color)
    opposite_color = {white: :black, black: :white}
    enemy_pieces = @grid.flatten.select{ |piece| piece.color == opposite_color[color] }
    king_pos = find_king(color)
    enemy_pieces.each do |piece|
      return true if piece.moves.include?(king_pos)
    end
    false
  end

  def find_king(color)
    @grid.flatten.select{ |piece| piece.color == color && piece.is_a?(King)}[0].position
  end
end
