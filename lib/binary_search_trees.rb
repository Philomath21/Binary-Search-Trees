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
    puts ' ' if node == root
  end

  def find_c(c_data, node = root, p_node = nil, side = nil)
    loop do
      return [node, p_node, side] if node.nil?

      case c_data <=> node.data
      when 0 then return [node, p_node, side]
      when -1 then p_node = node
                   node = node.left
                   side = -1
      when 1 then p_node = node
                  node = node.right
                  side = 1
      end
    end
  end
  # node, p_node, side = find_c(c_data)

  def find(c_data)
    node = find_c(c_data)[0]

    if node.nil?
      "#{c_data} does not exist in binary tree"
    else
      node
    end
  end

  def insert(c_data)
    node, p_node, side = find_c(c_data)

    if node.nil?
      case side
      when -1 then p_node.left = Node.new(c_data)
      when 1 then p_node.right = Node.new(c_data)
      end
    else
      puts "#{c_data} already exists in tree"
    end
  end

  def delete(c_data, root_node = root)
    node, p_node, side = find_c(c_data, root_node)

    if node.nil?
      puts 'Data does not exist in binary tree'
    elsif node.left && node.right
      p_sac_node = node
      sac_node = node.right
      loop do
        break if sac_node.left.nil?

        p_sac_node = sac_node
        sac_node = sac_node.left
      end
      node.data = sac_node.data
      delete(sac_node.data, p_sac_node)
    else
      case side
      when -1 then p_node.left = node.left || node.right
      when 1 then p_node.right = node.left || node.right
      end
    end
  end
end
