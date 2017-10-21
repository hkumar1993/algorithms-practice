require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  str_len = string.length
  char_hash = HashMap.new
  # count number of times each character appears in the string
  string.chars.each do |ch|
    if char_hash[ch]
      char_hash[ch] += 1
    else
      char_hash[ch] = 1
    end
  end

  # equivalent to Hash.values
  values = []
  char_hash.each do |ch, count|
    values << count
  end

  # if a palindrome is even in length,
  # all characters must have a coutn of even

  # if a palindrome is odd in length,
  # all characters except one must have a count of even



  if str_len.odd?
    # checking if just one character appears odd number of times
    return values.count(&:odd?) == 1
  else
    # checking if all characters appear even number of times
    return values.all?(&:even?)
  end

end
