require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
    @prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    popped = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    popped
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    @store = BinaryMinHeap.heapify_up(@store, count-1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    res = []
    first_child = 2 * parent_index + 1
    last_child = 2 * parent_index + 2
    res << first_child unless first_child >= len
    res << last_child unless last_child >= len
    res
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    return (child_index - 1) / 2 if child_index.odd?
    (child_index - 2) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc = prc || Proc.new do |el1, el2|
      el1 <=> el2
    end
    cur_idx = parent_idx
    child_ids = self.child_indices(len, parent_idx)

    preferred_child_idx = self.preferred_child(child_ids, prc, array)

    return array if preferred_child_idx.nil?

    until prc.call(array[cur_idx], array[preferred_child_idx]) < 0 || self.child_indices(len,cur_idx).empty?
      array[cur_idx], array[preferred_child_idx] = array[preferred_child_idx], array[cur_idx]
      cur_idx = preferred_child_idx
      break if self.child_indices(len, cur_idx).empty?
      child_ids = self.child_indices(len, cur_idx)
      preferred_child_idx = self.preferred_child(child_ids, prc, array)
      return array if preferred_child_idx.nil?
    end

    array
  end

  def self.preferred_child(child_ids, prc, array)
    return nil if child_ids.empty?

    if child_ids.length == 1
      return child_ids.first
    else
      compare_children = prc.call(array[child_ids.first], array[child_ids.last])

      if compare_children < 0
        return child_ids.first
      else
        return child_ids.last
      end
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc = prc || Proc.new do |el1, el2|
      el1 <=> el2
    end
    cur_idx = child_idx
    return array if cur_idx == 0
    parent_idx = self.parent_index(cur_idx)
    until prc.call(array[cur_idx], array[parent_idx]) >= 0 || cur_idx == 0
      array[cur_idx], array[parent_idx] = array[parent_idx], array[cur_idx]
      cur_idx = parent_idx
      break if cur_idx == 0
      parent_idx = self.parent_index(cur_idx)
    end
    array
  end
end
