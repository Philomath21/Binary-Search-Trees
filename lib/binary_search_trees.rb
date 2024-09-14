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

  # Complimentary method for use in other methods
  # method goes into the depth of the tree until node is nil or same as passed element
  # returns node, its parent node and side on which node is relative to parent node
  def find_condition(element, p_node = root)
    loop do
      side = element < p_node.data ? 'left' : 'right'
      node = side == 'left' ? p_node.left : p_node.right
      return [node, p_node, side] if node.nil? || node.data == element

      p_node = node
    end
  end
  # CODE FOR REUSING:
  # node, p_node, side = find_condition(element)

  def insert(element)
    p_node, side = find_condition(element)[1..]

    case side
    when 'left' then p_node.left = Node.new(element)
    when 'right' then p_node.right = Node.new(element)
    end
  end

  def find(element)
    node = find_condition(element)[0]

    if node.nil?
      puts 'element not found in binary tree'
    else
      node
    end
  end

  def delete(element, p_node = root)
    node, p_node, side = find_condition(element, p_node)

    if node.nil?
      # element not found in binary tree
      puts 'element not found in binary tree'

    elsif node.left && node.right
      # node has two children
      # Finding next lowest data that will replace the data in current node after deletion
      # This data will be found at deepest left child of right child
      new_element = find_condition(element, node.right)[1].data

      # replacing deleted data with next lowest data
      node.data = new_element

      # deleting old node of next lowest data
      delete(new_element, node)

    else
      # node has one or no child, deleting node by replacing it with child or nil
      next_node = node.left.nil? ? node.right : node.left
      side == 'left' ? p_node.left = next_node : p_node.right = next_node
    end
  end
end
