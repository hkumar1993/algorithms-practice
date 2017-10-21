require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    if check_index(index)
      @store[start_idx + index]
    else
      raise "index out of bounds"
    end
  end

  # O(1)
  def []=(index, val)
    if check_index(index)
      @store[start_idx + index] = val
    else
      raise "index out of bounds"
    end
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    ret = @store[@start_idx + @length-1]
    @store[@start_idx + @length-1] = nil
    @length -= 1
    ret
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @length += 1
    @store[@start_idx + @length - 1] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    @length -= 1
    ret = @store[@start_idx]
    @store[@start_idx] = nil
    @start_idx += 1
    ret
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @length += 1
    @start_idx -= 1
    @store[@start_idx] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    (0...@length).include?(index)
  end

  def resize!
    temp_arr = Array.new(@capacity * 2)
    (0..@length).each do |i|
      temp_arr[i] = @store[start_idx + i]
    end
    @store = temp_arr
    @capacity *= 2
    @start_idx = 0
  end
end
