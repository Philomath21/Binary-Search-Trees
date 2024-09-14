class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data)
    self.data = data
    self.left = nil     # left child node
    self.right = nil    # right child node
  end

  def to_s
    "#{data} (left = #{left&.data}, right = #{right&.data})"
  end
end

class Tree
  attr_accessor :array, :root

  def initialize(array)
    self.array = array
    self.root = build_tree(array)
  end

  # Method builds balanced binary tree from passed array, returns its root node
  def build_tree(sub_a)
    sorted_a = sub_a.sort
    mid_index = sorted_a.length / 2
    node = Node.new(sorted_a[mid_index])

    if sorted_a.length > 1
      node.left = build_tree(sorted_a[..mid_index - 1])
      node.right = build_tree(sorted_a[mid_index + 1..])
    end
    node
  end

  # Prints binary tree in visually easy format
  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find(c_data)
    node = root
    loop do
      return 'Not found' if node.nil?

      case c_data <=> node.data
      when -1 then node = node.left
      when 1 then node = node.right
      when 0 then return node
      end
    end
  end

  def insert(c_data)
    node = root
    p_node = nil
    side = nil
    loop do
      if node.nil?
        node = Node.new(c_data)
        side == -1 ? p_node.left = node : p_node.right = node
        return node
      end

      side = c_data <=> node.data
      case side
      when -1 then p_node, node = node, node.left # rubocop:disable Style/ParallelAssignment
      when 1 then p_node, node = node,  node.right # rubocop:disable Style/ParallelAssignment
      when 0 then return 'Data already exists in tree'
    end
  end

  def delete(c_data, node = root)
    while true
      return 'Not found' if node.nil?

      side = c_data <=> node.data
      case side
      when -1 then p_node, node = node, node.left # rubocop:disable Style/ParallelAssignment
      when 1 then p_node, node = node,  node.right # rubocop:disable Style/ParallelAssignment
      when 0 then break
      end
    end

    if node.left && node.right
      true
    else
      case side
      when -1 then p_node.left = node.left ? node.left : node.right
      when 1 then p_node.right = node.left ? node.left : node.right
      end
    end
  end
end
