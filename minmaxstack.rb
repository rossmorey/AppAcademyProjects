class MyQueue
  def initialize
    @store = []
  end

  def enqueue(n)
    @store << n
  end

  def dequeue
    @store.shift
  end

  def peek
    @store
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end


class MyStack
  def initialize
    @store = []
    @max = nil
    @min = nil
  end

  def pop
    @store.pop
  end

  def push(n)
    @store << n
    @max = n if @max.nil? || n > @max
    @mmin = n if @min.nil? || n < @min
  end

  def peek
    @store
  end

  def size
    @store.count
  end

  def empty?
    @store.empty?
  end

  def max
    @max
  end

  def min
    @min
  end
end

class StackQueue
  def initialize
    @in = MyStack.new
    @out = MyStack.new
  end

  def enqueue(n)
    @in.push(n)
  end

  def dequeue
    until @in.size == 1
      @out.push(@in.pop)
    end
    result = @in.pop
    until @out.empty?
      @in.push(@out.pop)
    end
    result
  end

  def size
    @in.size
  end

  def empty?
    @in.empty?
  end
end
