require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      @map[key]
    else
      value = calc!(key)
      @store.insert(key, value)
      @map[key] = @store.last
      update_list!
      value
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
  end

  def update_list!
    if count > @max
      key = @store.first.key
      @map.delete(key)
      @store.remove(key)
    end
  end

  def eject!
  end
end
