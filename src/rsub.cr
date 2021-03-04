class RSub
  property string : String

  def initialize(@string)
  end

  # Returns a String where the last occurrence of the given string is replaced with the block’s value.
  #
  # Example:
  #
  # stack = ["a", "b"]
  #
  # RSub.new("{} {}").sub("{}") do
  #   stack.pop
  # end
  #
  # ⇒ {} b
  def sub(string substring, &block : -> String)
    index = string.rindex(substring)
    if index
      start = index
      stop = start + substring.size

      string[...start] + yield + string[stop..]
    else
      string
    end
  end

  # Returns a String where all occurrences of the given string are replaced with the block’s value,
  # starting from the RHS.
  #
  # Example:
  #
  # stack = ["a", "b"]
  #
  # RSub.new("{} {}").gsub("{}") do
  #   stack.pop
  # end
  #
  # ⇒ a b
  def gsub(string substring, &block : -> String)
    memo = string
    while string.includes?(substring)
      @string = sub(substring, &block)
    end

    string.tap do
      @string = memo
    end
  end
end
