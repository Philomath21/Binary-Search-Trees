require_relative 'lib/binary_search_trees'

array = [16, 23, 100, 17, 21, 42, 44, 92, 78, 77, 38, 6, 27, 80, 22]

test_tree = Tree.new(array)
test_tree.build_tree(array)
test_tree.pretty_print
p array
# puts test_tree.root
