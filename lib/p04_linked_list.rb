class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  def initialize
    @sen_one = Link.new(:first, nil)
    @sen_two = Link.new(:last, nil)
    @sen_one.next = @sen_two
    @sen_two.prev = @sen_one
    @store = [@sen_one, @sen_two]
  end

  def [](i)
    @store.each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sen_one.next
  end

  def last
    @sen_two.prev
  end

  def empty?
    @sen_one.next == @sen_two
  end

  def get(key)

  end

  def include?(key)
  end

  def insert(key, val)
    link = Link.new(key, val)
    @store << link
    link.next = @sen_two
    before = @sen_two.prev
    before.next = link
    link.prev = before
    @sen_two.prev = link
  end

  def remove(key)
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
