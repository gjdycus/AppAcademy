#O(n^2) quadratic complexity
def my_min1(arr)
  arr.each do |el1|
    smallest = true
    arr.each do |el2|
      next if el1 == el2
      if el1 > el2
        smallest = false
      end
    end
    return el1 if smallest
  end
end

#O(n) linear complexity
def my_min2(arr)
  smallest = arr.first
  arr.each do |el|
    smallest = el if el < smallest
  end
  smallest
end

#O(n^2) quadratic complexity
def largest_contiguous_subsum1(arr)
  sub_arrays = []

  arr.each_index do |idx1|
    ((idx1)...arr.length).each do |idx2|
      sub_arrays << arr[idx1..idx2]
    end
  end

  # sub_arrays.max { |sub| sub.inject(&:+) }
  max = sub_arrays.first.inject(:+)
  sub_arrays.each do |sub_arr|
    sub_sum = sub_arr.inject(:+)
    max = sub_sum if sub_sum > max
  end
  #puts sub_arrays.length
  max
end

#O(n) linear complexity
def largest_contiguous_subsum2(arr)
  max = arr.first
  current_sum = 0
  arr.each do |el|
    current_sum += el
    max = current_sum if current_sum > max
    current_sum = 0 if current_sum < 0
  end
  max
end
