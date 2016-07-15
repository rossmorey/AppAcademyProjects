require 'colorize'
class Tile
  attr_writer :num_adj_bombs

  def initialize
     @bomb = false
     @reveal = false
     @flag = false
     @num_adj_bombs = 0
  end

  def reveal
    @reveal = true
  end

  def is_hidden?
    !@reveal
  end

  def is_visible?
    @reveal
  end

  def flag
    @flag = true
  end

  def unflag
    @flag = false
  end

  def is_flag?
    @flag
  end

  def set_bomb
    @bomb = true
  end

  def is_bomb?
    @bomb
  end

  def set_num(num)
    @num_adj_bombs = num
  end

  def show_num
    @num_adj_bombs
  end

  def to_s(debug=false)
    return "b".colorize(:red) if (@bomb && @reveal) || debug && @bomb
    return "f".colorize(:light_blue) if @flag
    color = @num_adj_bombs == 0? :blue : :yellow
    return @num_adj_bombs.to_s.colorize(color) if @reveal || debug
    " "
    if debug
      puts "press enter when ready"
      gets
    end
  end
end
