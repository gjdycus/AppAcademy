require_relative 'p02_hashing'
require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if count >= num_buckets
      resize!
      insert(key)
    else
      @store[key.hash % num_buckets] << key
      @count += 1
    end
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    @store[key.hash % num_buckets].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.flatten
    @count = 0
    @store = Array.new(num_buckets*2) { Array.new }
    old_store.each do |i|
      insert(i)
    end
  end
end
