def brute_force?(arr, value)
  arr.each_with_index do |n, i|
    (i+1...arr.length).each do |j|
      return true if n + arr[j] == value
    end
  end
  false
end

# time complexity O(n^2)

# arr = [0, 1, 5, 7]
# p brute_force?(arr, 6) # => should be true
# p brute_force?(arr, 10) # => should be false
# time complexity O(n^2)


def okay_two_sum?(arr, value)
  # arr.sort.each_with_index
  sorted = arr.sort
  # p sorted
  arr.each do |n|
    diff = value - n
    return true if bsearch(sorted, diff)
  end

  false
  #
  # queries = []
  # sorted.each do |n|
  #   diff = value - n
  #   unless diff == n #&& sorted.count(diff) <= 1
  #     queries << diff
  #   end
  # end
  # p queries
  # queries.each do |val|
  #   return true if sorted.include?(val)
  # end
  # false
end

def bsearch(arr, target)
  return nil if arr.empty?
  mid = arr.length / 2
  left = arr.take(mid)
  right = arr.drop(mid + 1)
  case target <=> arr[mid]
  when -1
    bsearch(left, target)
  when 0
    mid
  when 1
    sub_a = bsearch(right, target)
    sub_a.nil? ? nil : (mid + 1) + sub_a
  end
end

#
# def quick_sort(arr)
#   return arr if arr.length <= 1
#   pivot = arr.shift
#   left, right = arr.partition{|n| n < pivot}
#   quick_sort(left) + [pivot] + quick_sort(right)
# end

arr = [2, 1, 5, 7]
p okay_two_sum?(arr, 6)
p okay_two_sum?(arr, 10)

#time complexity: n log n

def hash_sort(arr, value)
  hash = Hash.new(0)
  arr.each { |n| hash[n] += 1 }
  queries = []
  arr.each do |n|
    diff = value - n
    return true if hash[diff] > 0
  end
  false
end

# arr = [2, 1, 5, 7]
# p hash_sort(arr, 6)
# p hash_sort(arr, 10)

# time complexity O(n)
