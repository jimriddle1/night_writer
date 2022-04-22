class Dictionary

  attr_reader :name, :lookup_table

  def initialize(name)
    @name = name
    @lookup_table = create_dictionary
  end

  def create_r
    ".0\n..\n.0"
  end

  def create_dictionary
    hash = {}
    hash["r"] = ".0\n..\n.0"
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
