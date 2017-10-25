require "byebug"
class DynamicProgramming

  attr_reader :super_steps_cache

  def initialize
    @blair_cache = {
      1 => 1,
      2 => 2
    }

    @frog_td_cache = {
      1 => [[1]],
      2 => [[1,1],[2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    }

    @super_steps_cache = {

    }
  end

  def blair_nums(n)
    if @blair_cache[n]
      @blair_cache[n]
    else
      prev_blair = blair_nums(n - 1) + blair_nums(n - 2)
      b_num = prev_blair + 2 * (n - 2) + 1
      @blair_cache[n] = b_num
      b_num
    end
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)
  end

  def frog_cache_builder(n)
    frog_bu_cache = {
      1 => [[1]],
      2 => [[1,1],[2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    }

    if n > 3
      (4..n).each do |i|
        seen = []
        res = []
        (1..3).each do |j|
          frog_bu_cache[i - j].each do |subs|
            res << [j] + subs
          end
        end
        frog_bu_cache[i] = res
      end
    end
    frog_bu_cache[n]
  end

  def frog_hops_top_down(n)
    return @frog_td_cache[n] if @frog_td_cache[n]
    ans = frog_hops_top_down_helper(n)
    @frog_td_cache[n] = ans
    ans
  end

  def frog_hops_top_down_helper(n)
    res = []
    return @frog_td_cache[n] if @frog_td_cache[n]
    frog_hops_top_down_helper(n-1).each { |subs| res << [1] + subs }
    frog_hops_top_down_helper(n-2).each { |subs| res << [2] + subs }
    frog_hops_top_down_helper(n-3).each { |subs| res << [3] + subs }
    res
  end

  def super_frog_hops(n, k)
    super_setup(k)
    return @super_steps_cache[n] if @super_steps_cache[n]
    ans = super_frog_helper(n, k)
    @super_steps_cache[n] = ans
    ans
  end

  def super_frog_helper(n, k)
    res = []
    return @super_steps_cache[n] if @super_steps_cache[n]
    (1..k).each do |i|
      super_frog_helper(n-i, k).each { |subs| res << [i] + subs }
    end
    res
  end

  def super_setup(k)
    base = {
      1 => [[1]],
      2 => [[1,1],[2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    }
    (1..k).each { |i| @super_steps_cache[i] = base[i] if base[i]}
    if k > 3
      (4..k).each do |i|
        seen = []
        res = []
        (1..@super_steps_cache.keys.max).each do |j|
          break if i == j
          @super_steps_cache[i - j].each do |subs|
            res << [j] + subs
          end
        end
        @super_steps_cache[i] = res << [i]
      end
    end
  end

  def knapsack(weights, values, capacity)
    knapsack_table(weights, values, capacity)
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    knapsack_cache = Array.new(capacity + 1) { Array.new(weights.length) }

    weights.each_with_index do |w, idx|
      knapsack_cache.each_index do |current_capacity|
        current_diff = current_capacity - w
        if current_diff < 0
          if idx == 0
            knapsack_cache[current_capacity][idx] = 0
          else
            knapsack_cache[current_capacity][idx] = knapsack_cache[current_capacity][idx - 1]
          end
        else
          current_value = values[idx]
          if idx == 0
            knapsack_cache[current_capacity][idx] = current_value
          else
            remaining_value = knapsack_cache[current_diff][idx - 1]
            previous_value = knapsack_cache[current_capacity][idx - 1]
            knapsack_cache[current_capacity][idx] = [current_value + remaining_value, previous_value].max
          end
        end
      end
    end
    knapsack_cache[-1][-1]
    # (w) v 0 1 2 3 4 5 6 7
    # (1) 1 0 1 1 1 1 1 1 1
    # (3) 4 0 1 1 4 5 5 5 5
    # (4) 5 0 1 1 4 5 6 6 9
    # (5) 7 0 1 1 4 5 7 8 9
    # max(current_value + Array[(current_capacity - current_weight)][current_weight - 1], previous_value_at_same_current_capacity)
  end

  def maze_solver(maze, start_pos, end_pos)

  end
end
