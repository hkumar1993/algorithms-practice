require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  tree = BinarySearchTree.new(tree_node)

  if tree_node.right
    right_node_count = tree.in_order_traversal(tree_node.right).length
    dif = k - right_node_count - 1
    if dif == 0
      return tree_node
    elsif dif < 0
      kth_largest(tree_node.right, k)
    else
      kth_largest(tree_node.left, dif)
    end
  else
    k -= 1
    return tree_node if k == 0
    kth_largest(tree_node.left, k)
  end
end
