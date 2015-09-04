require_relative 'my_stack.rb'

#O(n^2) quadratic complexity
def bad_windowed_max_range(array, window_size)
  current_max_range = nil

  (0..(array.length-window_size)).each do |idx|
    current_window = array[idx...(idx+window_size)]
    max = current_window.max
    min = current_window.min
    current_max_range = max - min if max - min > current_max_range.to_i
  end
  current_max_range
end

#O(n) linear complexity
def good_windowed_max_range(array, window_size)
  queue = MinMaxStackQueue.new
  copy = array.dup

  window_size.times { queue.enqueue(copy.shift) }
  current_max_range = queue.max - queue.min

  (array.length-window_size).times do
    queue.dequeue
    queue.enqueue(copy.shift)

    tmp = queue.max - queue.min
    current_max_range = tmp if tmp > current_max_range
  end
  current_max_range
end
