class PathNode

  attr_accessor :value, :children
  attr_reader :parent

  def initialize(value=nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    unless @parent.nil?
      old_parent = @parent
      old_parent.children.delete(self)
    end
    @parent = new_parent
    new_parent.children << self unless new_parent == nil
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "error" unless child_node.parent == self
    child_node.parent = nil
    # child_node.children.each {|child| child.parent = self}
  end

  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child|
      previous = child.dfs(target_value)
      return previous unless previous.nil?
    end
    nil
  end

  def bfs(target_value)
    q = [self]
    until q.empty?
      node = q.shift
      return node if node.value == target_value
      q.concat(node.children)
    end
  end

end
