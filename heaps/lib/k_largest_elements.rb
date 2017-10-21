require_relative 'heap'

def k_largest_elements(array, k)
  bmh = BinaryMinHeap.new
  array.each do |el|
    bmh.push(el)
  end
  sorted_array = []

  until bmh.count == 0
    sorted_array.push(bmh.extract)
  end

  sorted_array.drop(array.length - k)

end
