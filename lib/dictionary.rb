class Dictionary

  attr_reader :text_input, :lookup_table

  def initialize(input)
    @text_input = split_text(input)
    @lookup_table = create_dictionary
  end

  def split_text(input)
    input.split('')
  end

  def create_r
    "0.\n00\n0."
  end

  def create_dictionary
    hash = {}
    hash["r"] = "0.\n00\n0."
    return hash
  end

  def write(character)
    if @lookup_table.keys.include?(character) == false
      "Invalid Input"
    else
      @lookup_table[character]
    end
  end

end
