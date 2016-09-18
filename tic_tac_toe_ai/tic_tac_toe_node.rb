require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
      @board = board
      @next_mover_mark = next_mover_mark
      @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

    if board.over?
      return board.won? && board.winner != evaluator
    end

    if self.next_mover_mark == evaluator
      self.children.all? { |node| node.losing_node?(evaluator) }
    else
      self.children.any? { |node| node.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)

    if board.over?
      return board.winner == evaluator
    end

    if self.next_mover_mark == evaluator
      self.children.any? { |node| node.winning_node?(evaluator) }
    else
      self.children.all? { |node| node.winning_node?(evaluator) }
    end
  end


  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    (0..2).each do |row|
      (0..2).each do |col|
        unless board[[row, col]] == :x || board[[row, col]] == :o
          children << [row, col]
        end
      end
    end
    children.map do |child|
      new_board = Board.new(board_dup(@board.rows))
      new_board[child] = @next_mover_mark
      TicTacToeNode.new(new_board, change_next_mover_mark, child)
    end
  end

  def board_dup(grid)
    grid.map { |el| el.is_a?(Array) ? board_dup(el) : el }
  end

  def change_next_mover_mark
    @next_mover_mark == :o ? :x : :o
  end

end
