# require "byebug"

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 22345231 if self == []
    hash_val = 0
    self.each do |el|
      return 22345231 if el == []
      hash_val += el.to_s(2).to_i
    end
    hash_val = hash_val.to_s(2).to_i^self.last.to_s(2).to_i
    hash_val
  end
end

class String
  def hash
    split("").map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = values
    arr.concat(keys)
    arr.map!(&:to_s)
    arr.map!(&:ord)
    arr.sort.hash
  end
end
