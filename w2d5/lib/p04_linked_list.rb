require 'byebug'
class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    # nil
  end

  def first
    @head.next
  end

  def last
    prev_link = @head
    current_link = @head.next
    last_link = nil
    until current_link.nil?
      prev_link = current_link
      current_link = current_link.next
    end
    last_link = prev_link
    last_link
  end

  def empty?
    @head.next.nil?
  end

  def get(key)
    current_link = self.first

    until current_link.nil?
      if current_link.key == key
        return current_link.val
      else
        current_link = current_link.next
      end
    end
    nil
  end

  def include?(key)
    !get(key).nil?
  end

  def insert(key, val)
    self.last.next = Link.new(key, val, nil)
  end

  def remove(key)
    current_link = @head

    until current_link.key == key
      prev_link = current_link
      current_link = current_link.next
    end

    next_link = current_link.next
    prev_link.next = next_link
  end

  def each
    current_link = self.first

    until current_link.nil?
      yield(current_link)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
