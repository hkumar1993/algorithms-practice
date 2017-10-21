class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    res = 0
    self.each_with_index do |el, id|
      res = (el*id).hash
    end
    res
  end
end

class String
  def hash
    alphabet = ('a'...'z').to_a
    str_int = []
    self.each_byte do |c|
      str_int << c
    end
    str_int.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    res = 0
    self.keys.each do |key|
      res += key.hash * self[key].hash
    end
    res
  end
end
