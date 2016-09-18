require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map[key])
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    value = @prc.call(key)
    new_link = @store.insert(key, value)
    @map[key] = new_link
    eject! if @store.length > @max
    value
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    the_key = link.key
    the_val = link.val
    obj = @store.remove(the_key)
    obj.next = @store.sen_two
    before = @store.sen_two.prev
    before.next = obj
    @store.sen_two.prev = obj
    obj.prev = before
    link.val
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    the_key = @store.first.key
    @store.remove(the_key)
    @map.delete(the_key)

    #remove oldest val from list
    #remove key from map
  end
end
