list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]

def my_min_phase1(arr)

  arr.each_with_index do |num1, i|
    smallest = true
    arr.each_with_index do |num2, j|
      next if i == j
      smallest = false if num2 < num1
    end
    return arr[i] if smallest
  end
end

#Phase1: time complexity is O(n^2) for iterating through each element once
# p my_min_phase1(list)

#Phase2
def my_min_phase2(arr)
  smallest = arr.first
  arr.each do |num|
    smallest = num if num < smallest
  end
  smallest
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min_phase2(list)  # =>  -5
#Phase1: time complexity is O(n) for iterating through each element once


def largest_contiguous_subsum(arr)
  subarrays = []
  # arr.each_with_index do |num1, i|
  #   temp_sub = [num]
  #   subarrays << temp_sub
  #   arr.each_with_index do |num2, j|
  #     temp_sub << nu
  #   end
  # end
  arr.each_index do |i|
    i2 = i
    while i2 < arr.length
      subarrays << arr[i..i2]
      i2 += 1
    end
  end
  subarrays.length
  # subarrays.map! { |subr| subr.inject(:+) }
  # subarrays.sort.last
end

# list = [5, 3, -7]
# list = [2, 3, -6, 7, -6, 5, 8]
# 10.times do |i|
#   list = (0..i+1).to_a
#   p "list length = #{list.length}; subarray length: #{largest_contiguous_subsum(list) }"
#
# end
# p largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])

#Contiguous sum phase 1: time complexity is O(n**2) for loop within a loop

#
def largest_contiguous_subsum_2(arr)
  largest_sum = arr[0]
  arr.length.times do |i|

    sum = arr[0...arr.length-i].inject(:+)
    largest_sum = sum if !sum.nil? && sum > largest_sum
    sum = arr[arr.length-i...arr.length].inject(:+)
    largest_sum = sum if !sum.nil? && sum > largest_sum

  end
  largest_sum
end

list = [2, 3, -6, 7, -6,7]
p largest_contiguous_subsum_2(list)
