class Node
  include Comparable

  attr_accessor :data, :left_child, :right_child

  def initialize(data)
    self.data = data
    self.left_child = nil
    self.right_child = nil
  end
end

class Tree
  attr_accessor :array, :root

  def initialize(array)
    self.array = array
    self.root = nil
  end

  def build_tree(sub_a)
    sorted_a = sub_a.sort
    mid_index = sorted_a.length / 2
    self.root = Node.new(sorted_a[mid_index])

    if sorted_a.length > 1
      root.left_child = build_tree(sorted_a[..mid_index - 1])
      root.right_child = build_tree(sorted_a[mid_index + 1..])
    end
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(element)
    check_root = root
    check_child = "element == node data, I can't handle this yet!"

    loop do
      check_child = check_root.left_child if element < check_root.data
      check_child = check_root.right_child if element > check_root.data

      return check_child = Node.new(element) if check_child.nil?
      return puts check_child if check_child in String

      check_root = check_child
    end
  end

  def delete(element)
  end
end
