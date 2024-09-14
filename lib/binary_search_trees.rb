class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data)
    self.data = data
    self.left = nil
    self.right = nil
  end

  def to_s
    "#{data} (left = #{left}, right = #{right})"
  end
end

class Tree
  attr_accessor :array, :root

  def initialize(array)
    self.array = array
    self.root = build_tree(array)
  end

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

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find_condition(element, p_node = root)
    side = 'left or right' # side to check child node on
    node = ''
    loop do
      side = element < p_node.data ? 'left' : 'right'

      node = case side
             when 'left' then p_node.left
             when 'right' then p_node.right
             end

      return [node, p_node, side] if yield(node, p_node, side)

      p_node = node
    end
  end
  # info_a = find_condition(element)
  # node, p_node, side = info_a

  def insert(element)
    info_a = find_condition(element) { |node| node.nil? } # rubocop:disable Style/SymbolProc
    node, p_node, side = info_a
    p_node.left = Node.new(element) if node.nil?
  end

  def find(element)
    info_a = find_condition(element) { |node| node.data == element }
    info_a[0]
  end

  def delete(element, p_node = root)
    info_a = find_condition(element, p_node) { |node| node.data == element }
    node, p_node, side = info_a

    case
    when node.left.nil? then node = node.right
    when node.right.nil? then node = node.left
    else # both children are present
      new_info_a = find_condition(element, node.right) { |node| node.nil? } # rubocop:disable Style/SymbolProc
      succ_node = new_info_a[1]
      node.data = succ_node.data
      delete(succ_node.data, node)
      return
    end

    case side
    when 'left' then p_node.left = node
    when 'right' then p_node.right = node
    end
  end

  # def delete(element)
  #   if block_given?
  #     node, p_node, side = yield
  #   else
  #     node, p_node, side = find(element) { true }
  #   end

  #   if node.left.nil?
  #     node = node.right
  #   elsif node.right.nil?
  #     node = node.left
  #   else
  #     repl_node = node.right
  #     loop do
  #       if repl_node.left.nil?
  #         node.data = repl_node.data
  #         delete
  #       end
  #     end
  #   end

  #   case side
  #   when 'left' then p_node.left = node
  #   when 'right' then p_node.right = node
  #   end
  # end

  # def find(element)
  #   p_node = root
  #   side = 'left or right' # side to check child node on
  #   node = ''
  #   loop do
  #     side = element < p_node.data ? 'left' : 'right'

  #     node = case side
  #            when 'left' then p_node.left
  #            when 'right' then p_node.right
  #            end

  #     node.data == element ? break : p_node = node
  #   end

  #   block_given? ? [node, p_node, side] : node
  # end

  # def insert(element)
  #   p_node = root                                           # parent node
  #   node = "element == node data, I can't handle this yet!" # node

  #   loop do
  #     node = p_node.left if element < p_node.data
  #     node = p_node.right if element > p_node.data

  #     return node = Node.new(element) if node.nil?
  #     return puts node if node in String

  #     p_node = node
  #   end
  # end
end
