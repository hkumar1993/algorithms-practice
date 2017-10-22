require 'byebug'
class BSTNode
  include Enumerable

  attr_accessor :value, :left, :right, :parent

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end

  def <=>(node)
    @value <=> node.value
  end

  def left=(node)
    node.parent = self
    @left = node
  end

  def right=(node)
    node.parent = self
    @right = node
  end

  def delete_child(value)
    @left = nil if @left.value == value
    @right = nil if @right.value == value
  end

  def num_children
    if @left && @right
      return 2
    elsif @left && !@right || @right && !@left
      return 1
    else
      return 0
    end
  end

  def child
    if @left && !@right || @right && !@left
      return @left if @left
      return @right if @right
    end
  end

end
