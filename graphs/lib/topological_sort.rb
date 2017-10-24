require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  seen = []
  top = Queue.new
  vertices.each do |vertex|
    top.enqueue(vertex) if vertex.in_edges.empty?
  end
  vertices_copy = vertices.map {|v| v.value }
  until top.empty?
    current = top.dequeue
    sorted << current
    vertices_copy.delete(current.value)
    current.out_edges.each do |edge|
      to_vertex = edge.to_vertex
      to_vertex.in_edges.delete(edge)
      if to_vertex.in_edges.empty?
        top.enqueue(to_vertex)
      end
    end
  end
  return sorted if vertices_copy.empty?
  []
end

class Queue

  attr_reader :store
  include Enumerable

  def each(&block)
    @store.each(&block)
  end

  def initialize
    @store = []
  end

  def enqueue(value)
    @store.push(value)
  end

  def dequeue
    @store.shift
  end

  def empty?
    @store.empty?
  end
end
