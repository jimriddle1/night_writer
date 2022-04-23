class Dictionary

  attr_reader :text_input, :lookup_table, :is_braille

  def initialize(input)
    @text_input = split_text(input)
    @lookup_table = create_dictionary
    @is_braille = false
  end

  def split_text(input)
    # if input.include?("/n")
    #
    # else
    #
    # end
    text = input.split('')
    if text[-1] == "\n"
      return text[0..-2]
    end
    # require 'pry'; binding.pry
    return text
  end

  def create_r
    "0.\n00\n0."
  end

  def create_dictionary
    hash = {}
    hash["a"] = "0....."
    hash["b"] = "0.0..."
    hash["c"] = "00...."
    hash["d"] = "00.0.."
    hash["e"] = "0..0.."
    hash["f"] = "000..."
    hash["g"] = "0000.."

    hash["h"] = "0.00.."
    hash["i"] = ".00..."
    hash["j"] = ".000.."
    hash["k"] = "0...0."
    hash["l"] = "0.0.0."
    hash["m"] = "00..0."
    hash["n"] = "00.00."
    hash["o"] = "0..00."
    hash["p"] = "000.0."

    hash["q"] = "00000."
    hash["r"] = "0.000."
    hash["s"] = ".00.0."
    hash["t"] = ".0000."
    hash["u"] = "0...00"
    hash["v"] = "0.0.00"
    hash["w"] = ".000.0"
    hash["x"] = "00..00"
    hash["y"] = "00.000"
    hash["z"] = "0..000"

    hash[" "] = "......"
    return hash
  end

  def write(character)
    if @lookup_table.keys.include?(character) == false
      "Invalid Input"
    else
      @lookup_table[character]
    end
  end

  def write_braille_to_file
    braille = File.open("braille.txt", "w")
    top_row = ""
    mid_row = ""
    bot_row = ""
    count = 0
    @text_input.each do |character|
      count += 1
      top_row += "#{@lookup_table[character][0]}#{@lookup_table[character][1]}"
      mid_row += "#{@lookup_table[character][2]}#{@lookup_table[character][3]}"
      bot_row += "#{@lookup_table[character][4]}#{@lookup_table[character][5]}"
      if count % 40 == 0
        braille.write("#{top_row}\n")
        braille.write("#{mid_row}\n")
        braille.write("#{bot_row}\n")
        top_row = ""
        mid_row = ""
        bot_row = ""
      end
    end
      braille.write("#{top_row}\n")
      braille.write("#{mid_row}\n")
      braille.write("#{bot_row}")
    braille.close
  end

end
