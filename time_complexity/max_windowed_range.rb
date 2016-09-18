def windowed_max_range(arr, size)
  current_max_range = nil
  sorted = arr.sort

  (arr.length - size + 1).times do |i|
    window = arr.slice(i,size).sort
    max = window.last
    min = window.first
    current_max_range = max - min if current_max_range.nil? || current_max_range < max - min
  end

  current_max_range
end


p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
