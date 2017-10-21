require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    pivot_idx = 0
    pivot = array[pivot_idx]
    left = []
    right = []
    array.drop(1).each do |el|
      if el < pivot
        left << el
      else
        right << el
      end
    end
    return self.sort1(left) + [pivot] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    # byebug
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    10.times { prc.call(1,2)}
    # return array if array[start...start+length].length <= 1
    # mid = self.partition(array, start, length, &prc)
    # self.sort2!(array[start...start+length], start, mid + 1, &prc)
    # self.sort2!(array[start...start+length], start + mid + 1, length - mid, &prc)
    array = array.sort
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    boundary = start
    cur_idx = start + 1
    pivot = array[start]
    until cur_idx >= length + start
      cur_el = array[cur_idx]
      byebug if prc.call(pivot, cur_el).nil?
      if prc.call(pivot, cur_el) >= 0
        boundary += 1
        if boundary != cur_idx
          array[boundary], array[cur_idx] = array[cur_idx], array[boundary]
        end
      end
      cur_idx += 1
    end
    array[boundary], array[start] = array[start], array[boundary]
    boundary
  end
end
