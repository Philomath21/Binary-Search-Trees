# Driver script
require_relative 'lib/binary_search_trees'

puts 'Create a binary search tree from an array of random numbers'
test_a = (Array.new(15) { rand(1..100) })
tree_t = Tree.new(test_a)
tree_t.pretty_print

puts 'Confirm that the tree is balanced by calling #balanced?'
puts tree_t.balanced?

puts " \nPrint out all elements in level, pre, post, and in order"
puts "Level order: #{tree_t.level_order}"
puts "Preorder:    #{tree_t.preorder}"
puts "Postorder:   #{tree_t.postorder}"
puts "Inorder:     #{tree_t.inorder}"

puts " \nUnbalance the tree by adding several numbers > 100"
puts '#insert : 101, 105, 110, 115, 145, 170, 199'
tree_t.insert 101
tree_t.insert 105
tree_t.insert 110
tree_t.insert 115
tree_t.insert 145
tree_t.insert 170
tree_t.insert 199
tree_t.pretty_print

puts 'Confirm that the tree is unbalanced by calling #balanced?'
puts tree_t.balanced?

puts " \nBalance the tree by calling #rebalance"
tree_t.rebalance
tree_t.pretty_print

puts 'Confirm that the tree is balanced by calling #balanced?'
puts tree_t.balanced?

puts " \nPrint out all elements in level, pre, post, and in order"
puts "Level order: #{tree_t.level_order}"
puts "Preorder:    #{tree_t.preorder}"
puts "Postorder:   #{tree_t.postorder}"
puts "Inorder:     #{tree_t.inorder}"

puts " \nDeleting few nodes
#delete : 110"
tree_t.delete 110
tree_t.pretty_print
puts '#delete : 101'
tree_t.delete 101
tree_t.pretty_print

puts 'Finding nodes, their depth & height : 115, 199'
puts node_115 = tree_t.find(115)
puts node_199 = tree_t.find(199)
puts "depth of 115: #{tree_t.depth(node_115)}"
puts "depth of 199: #{tree_t.depth(node_199)}"
puts "height of 115: #{tree_t.height(node_115)}"
puts "height of 199: #{tree_t.height(node_199)}"
puts ' '

puts 'Rebalancing again'
tree_t.rebalance
tree_t.pretty_print
