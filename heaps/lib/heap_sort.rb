require_relative "heap"

class Array
  def heap_sort!
    bmh = BinaryMinHeap.new
    until self.empty?
      bmh.push(self.pop)
    end

    until bmh.store.empty?
      self.push(bmh.extract)
    end
  end
end
