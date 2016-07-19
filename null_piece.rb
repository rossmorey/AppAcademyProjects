require 'singleton'
class NullPiece
  include Singleton
  def to_s
    "   "
  end
  def empty?
    returns true
  end

  def color
    "   "
  end
end
