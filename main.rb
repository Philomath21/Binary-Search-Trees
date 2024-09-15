require_relative 'lib/binary_search_trees'

array = [16, 23, 100, 17, 21, 42, 44, 92, 78, 77, 38, 6, 27, 80, 22]
p array

test_tree = Tree.new(array)
# test_tree.pretty_print

test_tree.insert(88)
test_tree.pretty_print

# puts test_tree.find(80)
# puts test_tree.find(38)
# puts test_tree.find(8)

# test_tree.delete(78)
# test_tree.pretty_print

# test_tree.delete(80)
# test_tree.pretty_print

test_tree.delete(8)
test_tree.pretty_print
