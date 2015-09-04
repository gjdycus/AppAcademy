#O(n^2) quadratic complexity
def bad_two_sum?(arr, target_sum)
  arr.each_with_index do |el1, idx1|
    arr.each_with_index do |el2, idx2|
      return true if el1 + el2 == target_sum && idx1 != idx2
    end
  end
  false
end

#O(n^2) quadratic complexity
def okay_two_sum?(arr, target_sum)
  arr.sort!

  idx1 = 0
  idx2 = arr.length - 1

  while idx1 < idx2
    if arr[idx1] + arr[idx2] > target_sum
      idx2 -= 1
    elsif arr[idx1] + arr[idx2] < target_sum
      idx1 += 1
    else
      return true
    end
  end
  false
end

#O(n) linear time
def pair_sum?(arr, target_sum)
  hsh = Hash.new {|h,k| h[k] = false}

  #O(n)
  arr.each do |el|
    hsh[el] = true
  end
  #O(n)
  arr.each do |el|
    diff = target_sum - el
    next if diff == el
    return true if hsh[target_sum-el]
  end

  false
end
