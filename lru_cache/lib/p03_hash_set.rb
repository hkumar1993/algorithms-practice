require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == @store.length
    self[key] << key
    @count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    resize! if count == @store.length
    self[key].delete(key)
    @count -= 1
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = Array.new(num_buckets * 2){ Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        temp_store[num.hash % temp_store.length] << num
      end
    end
    @store = temp_store
  end
end
