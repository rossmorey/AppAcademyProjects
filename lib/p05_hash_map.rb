require_relative 'p02_hashing'
require_relative 'p04_linked_list'
# require 'byebug'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    return true unless get(key).nil?
    return false
  end

  def set(key, val)
    resize! if count == num_buckets
    if include?(key)
      delete(key)
    end
    @store[key.hash % num_buckets].insert(key, val)
    @count += 1
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    @store[key.hash % num_buckets].remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |linked_list|
      linked_list.each(&prc)
    end
  end


  # uncomment when you have Enumerable included
  def to_s
    # debugger
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    pairs.join("")
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    objects = []
    @store.each do |linked_list|
      linked_list.each do |link|
        objects << link
      end
    end
    @store = (Array.new(num_buckets * 2) { LinkedList.new })
    objects.each do |link|
      @store[link.key.hash % num_buckets].insert(link.key, link.val)
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
