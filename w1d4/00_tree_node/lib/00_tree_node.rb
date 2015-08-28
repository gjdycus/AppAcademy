class PolyTreeNode
  attr_reader :parent, :value
  attr_accessor :children

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(tree)
    parent.children.delete(self) unless parent.nil?
    @parent = tree
    tree.children << self unless tree.nil?
  end

  def add_child(child_node)
    child_node.parent = self
    children << child_node unless children.include?(child_node)
  end

  def remove_child(child_node)
    raise "Not my child" unless children.include?(child_node)
    child_node.parent = nil
    children.delete(child_node)
  end

  def dfs(target_value)
    return self if value == target_value
    return nil if children.empty?
    children.each do |child|
      child_dfs = child.dfs(target_value)
      return child_dfs if child_dfs
    end
    nil
  end

  def bfs(target_value)
    queue = [ self ]
    until queue.empty?
      current_node = queue.shift
      if current_node.value == target_value
        return current_node
      else
        queue += current_node.children
      end
    end
    nil
  end

  def trace_path_back
    return [value] if parent.nil?
    path = []
    path.concat(parent.trace_path_back)
    path.push(value)
    path
  end
end
