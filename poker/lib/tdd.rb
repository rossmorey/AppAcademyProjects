class Array
  def my_uniq()
    hash = Hash.new(0)#{|h,k| h[k] = [] }
    self.each do |ele|
      hash[ele] += 1
    end
    hash.keys
  end

  def two_sum
    result = []
    (0..length-2).each do |i1|
      (i1..length-1).each do |i2|
        if i1 != i2 && self[i1] + self[i2] == 0
          result << [i1, i2]
        end
      end
    end
    result
  end

  def my_transpose
    result = Array.new(self.length) { Array.new() }
    length.times do |i|
      length.times do |j|
        result[j] << self[i][j]
      end
    end
    result
  end

  def stock_picker
    temp = [0,0]
    (0..length-2).each do |i|
      (i..length-1).each do |j|
        if self[i] != self[j] &&
          ((temp.last - temp.first) < (self[j] - self[i]))
          temp = [i, j]
        end
      end
    end
    temp
  end
end
