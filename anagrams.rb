

# def anagram_1?(word1, word2)
#   anagrams = first_anagram(word1)
#   anagrams.include?(word2)
# end

def first_anagram?(word, other_word)
  anagram_arrays = word.split("").permutation(word.length).to_a
  anagrams = anagram_arrays.map {|word| word.join("")}
  anagrams.include?(other_word)
end

# first_anagram?("gizmo")
# p first_anagram?("gizmo", "sally")    #=> false
# p first_anagram?("elvis", "lives")    #=> true

#Phase 1: O(n!) time

def second_anagram?(word1, word2)
  # i = 0
  # until word1.empty? || word2.empty?
  #
  #
  # end
  # word1_arr = word1.split("")
  # word2_arr = word2.split("")
  word1_dup = word1.dup
  word2_dup = word2.dup
  word1.length.times do |i|
    char = word1[i]
    p char
    if word2.include?(char)
      word1_idx = word1_dup.index(char)
      word2_idx = word2_dup.index(char)
      word1_dup[word1_idx] = ""
      word2_dup[word2_idx] = ""
    end
  end
  word1_dup.length == 0 && word2_dup.length == 0
end

# p second_anagram?("gizmo", "sally")    #=> false
# p second_anagram?("elvis", "lives")    #=> true
#phase 2 is probably O(n^2) in the worst case


def third_anagram?(word1, word2)
  word1.split("").sort == word2.split("").sort
end
# p third_anagram?("gizmo", "sally")    #=> false
# p third_anagram?("elvis", "lives")    #=> true

#phase 3 is probably O(n^2) despite being 1 line of code; the Array#sort method
# uses quick sort, which in the worst case is O(n^2) (worst case, O(nlog) in the avg case)


def fourth_anagram?(word1,word2)
  word1_hash = Hash.new(0)
  word2_hash = Hash.new(0)
  word1.split("").each {|l| word1_hash[l] += 1}
  word2.split("").each {|l| word2_hash[l] += 1}
  word1_hash == word2_hash
end

# p fourth_anagram?("gizmo", "sally")    #=> false
# p fourth_anagram?("elvis", "lives")    #=> true

#fourth anagram complexity O(n)


def bonus_anagram?(word1,word2)
  hash = Hash.new(0)
  word1.split("").each {|l| hash[l] += 1}
  word2.split("").each {|l| hash[l] += 1}
  hash.values.all? { |value| value.even? }
end

p bonus_anagram?("gizmo", "sally")    #=> false
p bonus_anagram?("elvis", "lives")    #=> true

# bonus time complexity O(n)
