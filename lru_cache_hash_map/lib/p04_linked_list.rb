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
  include Enumerable

  attr_accessor :sen_two

  def initialize
    @sen_one = Link.new(:head, nil)
    @sen_two = Link.new(:tail, nil)
    @sen_one.next = @sen_two
    @sen_two.prev = @sen_one
    @store = [@sen_one, @sen_two]
  end

  def [](i)
    count =0
    each do |link|
      return link if i == count
      count += 1
    end
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
    each {|link| return link.val if link.key == key}
    nil
  end

  def include?(key)
    each {|link| return true if link.key == key}
    false
  end


  def insert(key, val)
    link = Link.new(key, val)
    @store << link
    link.next = @sen_two
    before = @sen_two.prev
    before.next = link
    link.prev = before
    @sen_two.prev = link
    link
  end

  def remove(key)
    each do |link|
      if link.key == key
        link.prev.next, link.next.prev = link.next, link.prev
#        link.val = nil
        return link
      end
    end
    nil
  end

  def each(&prc)
    link = first
    until link.next.nil?
      prc.call(link)
      link = link.next
    end
  end

  def length
    l = 0
    each { |link| l += 1 }
    return l
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
