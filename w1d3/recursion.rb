require 'byebug'

def range(start, finish)
  return Array.new if finish < start
  return [start] if start == finish
  [start] + range(start + 1, finish)
end

def sum_of_array_recursion(arr)
  return arr[0] if arr.length <= 1
  arr.pop + sum_of_array(arr)
end

def sum_of_array_iteration(arr)
  arr.reduce(:+)
end

def exp_1(b, n)
  return 1 if n == 0
  b * exp_1(b, n - 1)
end

def exp_2(b, n)
  return 1 if n == 0
  return b if n == 1
  if n.even?
    first_half = exp_2(b, (n / 2))
    return first_half * first_half
  else
    first_half = exp_2(b, ((n-1)/2))
    return b * first_half *first_half
  end
end

def deep_dup(arr)
    return arr.dup if arr.none? {|el| el.is_a?(Array)}

    arr.dup.map {|el| el.is_a?(Array) ? deep_dup(el) : el }
end

def fibonacci_recursion(n)
  return [] if n == 0
  return [1] if n == 1
  last_arr = fibonacci_recursion(n-1)
  second_to_last_number = last_arr[-2] || 0

  last_arr << second_to_last_number + last_arr.last
end

def fibonacci_iteration(n)
  return [] if n == 0
  return [1] if n == 1
  arr = [1,1]
  (n-2).times { arr << arr.last + arr[-2] }
  arr
end

def bsearch(arr, target)
    return nil if arr.empty?

    if arr.length == 1
      return arr[0] == target ? 0 : nil
    end

    middle_index = arr.length / 2
    return middle_index if arr[middle_index] == target
    if target < arr[middle_index]
      bsearch(arr[0...middle_index], target)
    else
      # if bsearch[...] returns nil, this whole branch should return nil
      result = bsearch(arr[(middle_index + 1)..-1], target)
      return nil if result.nil?
      result + middle_index + 1
    end
end

def make_change(target, coins)
  coins = coins.sort.reverse
  smallest_coin = coins.last
  return [] if target == 0
  return [smallest_coin] if target == smallest_coin
  current_best = nil
  coins.each_with_index do |coin, idx|
      # p ['coin: ', coin, 'target: ', target]
    if coin <= target
      best_change = make_change((target - coin), coins.drop(idx))

      if !current_best || best_change.length < current_best.length
        # debugger
        # p ['current_best: ', current_best]
        current_best = [coin] + best_change
        # p ['current_best: ', current_best]

      end
    end
  end
    current_best
end


def merge_sort(arr)
  return arr if arr.length < 2
  if arr.length >= 2
    middle_index = arr.length / 2
    merge(merge_sort(arr[0...middle_index]), merge_sort(arr[middle_index .. -1]))
  end
end

def merge(half1, half2)
  result = []
  until half1.empty? || half2.empty?
    if half1.first > half2.first
      result << half2.shift
    else
      result << half1.shift
    end
  end
  result + half1 + half2
end


def subsets(arr)
  return [[]] if arr.length == 0
  last_el = arr[-1]
  previous_subset = subsets(arr.take(arr.length - 1))
  previous_subset + previous_subset.map { |el| el + [last_el] }
end
