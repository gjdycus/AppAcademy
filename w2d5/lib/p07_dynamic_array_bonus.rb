class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    @store.each do |n|
      return true if n == val
    end
    false
  end

  def push(val)
    if count + 1 > capacity
      resize!
      push(val)
    else
      @store[count] = val
      @count += 1
    end
  end

  def unshift(val)
    if count + 1 > capacity
      resize!
      unshift(val)
    else
      new_ary = StaticArray.new(capacity)
      new_ary[0] = val

      idx = 1
      while idx < count
        new_ary[idx] = @store[idx]
        idx += 1
      end

      @store = new_ary
    end
  end

  def pop
    val = @store[count - 1]
    @store[count - 1] = nil
    val
  end

  def shift
    val = @store[0]

    new_ary = StaticArray.new(capacity)
    first = @store[0]

    idx = 1
    while idx < count
      new_ary[idx - 1] = @store[idx]
      idx += 1
    end

    @store = new_ary
    first
  end

  def first
    @store[0]
  end

  def last
    @store[count - 1]
  end

  def each
    idx = 0
    while idx < count
      yield(@store[idx])
      idx += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
  end
end
