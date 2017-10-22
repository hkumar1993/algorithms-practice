# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'
require 'byebug'

class BinarySearchTree

  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root = BSTNode.new(value)
    else
      insert_into(value, @root)
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if tree_node.value == value
    if value < tree_node.value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    node = find(value)
    children = node.num_children
    if children == 0
      if node.parent
        node.parent.delete_child(value)
      else
        @root = nil
      end
    elsif children == 1
      parent = node.parent || @root
      child = node.child
      if child.value < parent.value
        parent.left = child
      else
        parent.right = child
      end
    else
      max_node = maximum(node.left)
      temp_value = max_node.value
      delete(temp_value)
      node.value = temp_value
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    if tree_node.right.nil?
      return tree_node
    else
      maximum(tree_node.right)
    end
  end

  def depth(tree_node = @root)
    if tree_node.nil?
      return -1
    else
      left_depth = depth(tree_node.left)
      right_depth = depth(tree_node.right)
      if(left_depth > right_depth)
        return left_depth + 1
      else
        return right_depth + 1
      end
    end
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    return true if depth(tree_node) == 0

    balance = depth(tree_node.left) - depth(tree_node.right)

    if balance.abs <= 1
      return true if is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
    end
    false
  end

  def in_order_traversal(tree_node = @root, arr = [])
    # byebug
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end

  private
  # optional helper methods go here:
  def insert_into(value, tree_node)
    if value < tree_node.value
      if tree_node.left.nil?
        tree_node.left = BSTNode.new(value)
      else
        insert_into(value, tree_node.left)
      end
    else
      if tree_node.right.nil?
        tree_node.right = BSTNode.new(value)
      else
        insert_into(value, tree_node.right)
      end
    end
  end


end
