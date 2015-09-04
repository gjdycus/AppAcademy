#O(n!) factorial complexity
def first_anagram(str1, str2)
  permutations = str1.split("").permutation(str1.length).map(&:join)
  permutations.include?(str2)
end

#O(n^2) quadratic complexity
def second_anagram(str1, str2)
  ary1 = str1.split("")
  ary2 = str2.split("")

  ary1.each do |letter1|
    ary2.each do |letter2|
      if letter1 == letter2
        str1.sub!(letter1, "")
        str2.sub!(letter2, "")
      end
    end
  end

  str1.empty? && str2.empty?
end

#O(n^2) quadratic complexity
def third_anagram(str1, str2)
  str_sort(str1) == str_sort(str2)
end

def str_sort(str)
  str = str.split("")
  sorted = false
  unsorted_count = 0

  until sorted
    (str.length-1).times do |idx|
      if str[idx] > str[idx+1]
        unsorted_count += 1
        str[idx], str[idx+1] = str[idx+1], str[idx]
      end
    end

    if unsorted_count > 0
      sorted = false
      unsorted_count = 0
    else
      sorted = true
    end
  end
  str.join("")
end

#O(n) linear complexity
def fourth_anagram(str1, str2)
  hsh1 = Hash.new {|h,k| h[k] = 0}
  hsh2 = Hash.new {|h,k| h[k] = 0}

  str1.split("").each do |letter|
    hsh1[letter] += 1
  end

  str2.split("").each do |letter|
    hsh2[letter] += 1
  end

  hsh1 == hsh2
end
