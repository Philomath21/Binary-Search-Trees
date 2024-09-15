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

  def find_c(c_data, node = root, p_node = nil, side = nil)
    loop do
      return [node, p_node, side] if node.nil?

      side = c_data <=> node.data
      case side
      when -1 then p_node, node = node, node.left # rubocop:disable Style/ParallelAssignment
      when 1 then p_node, node = node,  node.right # rubocop:disable Style/ParallelAssignment
      when 0 then return [node, p_node, side]
      end
    end
  end
  # node, p_node, side = find_c(c_data)

  def find(c_data)
    node = find_c(c_data)[0]
    node.nil? ? 'Data does not exist in binary tree' : node
  end

  def insert(c_data)
    p_node, side = find_c(c_data)[1, 2]
    case side
    when -1 then p_node.left = Node.new(c_data)
    when 1 then p_node.right = Node.new(c_data)
    when 0 then 'Data already exists in tree'
    end
  end

  def delete(c_data, root_node = root)
    node, p_node = find_c(c_data, root_node)[0, 1]

    if node.nil?
      puts 'Data does not exist in binary tree'
    elsif node.left && node.right
      p_sac_node, sac_node = node, node.right                 # rubocop:disable Style/ParallelAssignment
      loop do
        break if sac_node.left.nil?                           # rubocop:disable Layout/EmptyLineAfterGuardClause
        p_sac_node, sac_node = sac_node, sac_node.left        # rubocop:disable Style/ParallelAssignment
      end
      node.data = sac_node.data
      delete(sac_node.data, p_sac_node)
    else
      side = p_node.left == node ? -1 : 1
      case side
      when -1 then p_node.left = node.left || node.right
      when 1 then p_node.right = node.left || node.right
      end
    end
  end
end
