require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    if check_index(index)
      @store[index]
    else
      raise "index out of bounds"
    end
  end

  # O(1)
  def []=(index, value)
    if check_index(index)
      @store[index] = value
    else
      raise "index out of bounds"
    end
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @store[@length-1] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @length += 1
    @store[@length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    (1..@length-1).each do |i|
      @store[i-1] = @store[i]
    end
    @store[@length-1]=nil
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    @length += 1
    temp = @store[0]
    @store[0] = val
    (1..@length-1).each do |i|
      temp, @store[i] = @store[i], temp
    end
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    (0...@length).include?(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    temp_arr = Array.new(@capacity * 2)
    (0..@length).each do |i|
      temp_arr[i] = @store[i]
    end
    @store = temp_arr
    @capacity *= 2
  end
end
