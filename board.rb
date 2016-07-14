require_relative 'tile'
require 'colorize'

DIRECTIONS = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]

class Board


  def initialize(grid = 9, num_bombs = 10)
    @grid_size = grid
    @grid = Array.new(grid) { Array.new(grid) {Tile.new} }
    @num_bombs = num_bombs
    place_bombs
    populate_counts
  end

  def place_bombs
    flat_shuffled_grid = @grid.flatten.shuffle
    @num_bombs.times { flat_shuffled_grid.pop.set_bomb }
  end

  def render(debug=false)
    @grid.each do |row|
      row.each do |x|
        print "[#{x.to_s(debug)}]"
      end
      puts
    end
  end

  def populate_counts
    @grid_size.times do |row_idx|
      @grid_size.times do |col_idx|
        current_tile = @grid[row_idx][col_idx]
        current_tile.set_num(count_bombs(row_idx,col_idx))
      end
    end
  end

  def count_bombs(row_idx, col_idx)
    num_bombs = 0
    DIRECTIONS.each do |direction|
      drow, dcol = direction
      ass_row = row_idx + drow
      ass_col = col_idx + dcol
      if ass_row.between?(0, @grid_size - 1) &&
        ass_col.between?(0, @grid_size -1)
        num_bombs += 1 if @grid[ass_row][ass_col].is_bomb?
      end
    end
    num_bombs
  end

  def won?
    flag_count = 0
    bomb_count = 0
    correctly_flagged_count = 0
    @grid.flatten.each do |tile|
      flag_count += 1 if tile.is_flag?
      bomb_count += 1 if tile.is_bomb?
      correctly_flagged_count += 1 if tile.is_flag? && tile.is_bomb?
    end
    won = correctly_flagged_count == bomb_count && flag_count == bomb_count
  end

  def [](array)
    row, col = array
    @grid[row][col]
  end
end
