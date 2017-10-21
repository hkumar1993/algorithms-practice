class Node
  attr_accessor :key, :val, :next, :prev


  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new('head', nil)
    @tail = Node.new('tail', nil)
    @head.prev = nil
    @head.next = @tail
    @tail.prev = @head
    @tail.next = nil
  end

  def [](i)
    each_with_index { |node, idx| return node if i == idx }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next.key == 'tail'
  end

  def get(key)
    node = find_node(key)
    return nil if node.nil?
    node.val
  end

  def include?(key)
    each { |node| return true if node.key == key}
    false
  end

  def append(key, val)
    node = Node.new(key,val)
    @tail.prev.next = node
    node.prev = @tail.prev
    node.next = @tail
    @tail.prev = node

  end

  def update(key, val)
    node = find_node(key)
    return nil if node.nil?
    node.val = val
  end

  def remove(key)
    node = find_node(key)
    return nil if node.nil?
    node.remove
  end

  def each
    current_node = @head.next
    until current_node.key == 'tail'
      yield(current_node)
      current_node = current_node.next
    end
  end

  protected

  def find_node(key)
    current_node = @head
    until current_node.key == key || current_node.key == 'tail'
      current_node = current_node.next
    end
    return nil if current_node.key == 'tail'
    current_node
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
