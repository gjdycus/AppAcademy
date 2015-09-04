class MyStack
  def initialize
    @store = []
  end

  def pop
    @store.pop
  end

  def push(val)
    if peek.nil?
      @store.push({val: val, maximum: val, minimum: val})
    else
      largest_val = peek[:maximum]
      if val > largest_val
        largest_val = val
      end

      lowest_val = peek[:minimum]
      if val < lowest_val
        lowest_val = val
      end

      @store.push({val: val, maximum: largest_val, minimum: lowest_val})
    end
  end

  def peek
    @store.last
  end

  def size
    @store.size
  end

  def max
    @store.last[:maximum]
  end

  def min
    @store.last[:minimum]
  end
end

class MinMaxStackQueue
  def initialize
    @stack1 = MyStack.new
    @stack2 = MyStack.new
  end

  def enqueue(val)
    until @stack2.size == 0
      @stack1.push(@stack2.pop[:val])
    end

    @stack1.push(val)
  end

  def dequeue
    until @stack1.size == 0
      @stack2.push(@stack1.pop[:val])
    end

    @stack2.pop[:val]
  end

  def peek
    @stack1.peek
  end

  def size
    @stack1.size
  end

  def max
    @stack1.max
  end

  def min
    @stack1.min
  end
end
