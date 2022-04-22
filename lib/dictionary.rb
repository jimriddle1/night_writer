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
    hash["a"] = "0.\n..\n.."
    hash["b"] = "0.\n0.\n.."
    hash["c"] = "00\n..\n.."
    hash["d"] = "00\n.0\n.."
    hash["e"] = "0.\n.0\n.."
    hash["f"] = "00\n0.\n.."
    hash["g"] = "00\n00\n.."

    hash["h"] = "0.\n00\n.."
    hash["i"] = ".0\n0.\n.."
    hash["j"] = ".0\n00\n.."
    hash["k"] = "0.\n..\n0."
    hash["l"] = "0.\n0.\n0."
    hash["m"] = "00\n..\n0."
    hash["n"] = "00\n.0\n0."
    hash["o"] = "0.\n.0\n0."
    hash["p"] = "00\n0.\n0."

    hash["q"] = "00\n00\n0."
    hash["r"] = "0.\n00\n0."
    hash["s"] = ".0\n0.\n0."
    hash["t"] = ".0\n00\n0."
    hash["u"] = "0.\n..\n00"
    hash["v"] = "0.\n0.\n00"
    hash["w"] = ".0\n00\n.0"
    hash["x"] = "00\n..\n00"
    hash["y"] = "00\n.0\n00"
    hash["z"] = "0.\n.0\n00"

    hash[" "] = "..\n..\n.."
    return hash
  end

  def write(character)
    if @lookup_table.keys.include?(character) == false
      "Invalid Input"
    else
      @lookup_table[character]
    end
  end

  def write_to_file
    braille = File.open("braille_test.txt", "w")

    text = @text_input.map do |character|
      @lookup_table[character]
    end
    output = text.join
    braille.write(output)
    braille.close
  end

end
