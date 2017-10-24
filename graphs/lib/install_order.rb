# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to
require_relative 'graph'
require_relative 'topological_sort'


def install_order(arr)
  vertices = Hash.new()
  (1..arr.flatten.uniq.max).each do |val|
    vertices[val] = Vertex.new(val)
  end
  arr.each do |packages|
    Edge.new(vertices[packages[1]], vertices[packages[0]])
  end
  res = topological_sort(vertices.values)
  # byebug
  res.map { |v| v.value  }
end
