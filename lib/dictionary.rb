class Dictionary

  attr_reader :text_input, :lookup_table, :input_braille

  def initialize(input)
    @text_input = split_text(input)
    @lookup_table = create_dictionary
    @input_braille = is_braille?(input)
  end

  def split_text(input)
    if is_braille?(input)
      braille_text = input.split('')
      # require 'pry'; binding.pry
      if braille_text[-1] == "\n"
        return braille_text[0..-2]
      end
      return braille_text
    else
      text = input.split('')
      if text[-1] == "\n"
        return text[0..-2]
      end
      return text
    end
  end

  def text_to_rows
    return_count = 0
    top_row = []
    mid_row = []
    bot_row = []
    @text_input.each do |letter|
      return_count += 1 if letter == "\n"
      if return_count % 3 == 0
        top_row << letter if letter != "\n"
      elsif return_count % 3 == 1
        mid_row << letter if letter != "\n"
      else return_count % 3 == 2
        bot_row << letter if letter != "\n"
      end
    end
    [top_row, mid_row, bot_row]
  end

  def rows_to_character
    braille_text = text_to_rows.join
    @lookup_table.key(braille_text)
  end

  def read_characters
    message = ""
    letter = ""
    adjustable_text_to_rows = text_to_rows
    while adjustable_text_to_rows.flatten.size != 0 do
      # require "pry"; binding.pry
      adjustable_text_to_rows.each do |row|

        letter << row[0]
        letter << row[1]
        row.shift(2)
      end
      message << @lookup_table.key(letter)
      letter = ""

    end

    original_message = File.open("original_message.txt", "w")
    original_message.write(message)
    return message
  end

  def is_braille?(text)
    text.length == (text.count("0") + text.count(".") + text.count("\n"))
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
    hash["cap"] = ".....0"
    return hash
  end

  def write_brail(character)
    if character == character.upcase && character != character.downcase && @lookup_table.keys.include?(character.downcase)
      "Capital"
    elsif @lookup_table.keys.include?(character) == false
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
      if write_brail(character) == "Invalid Input"
        braille.write("Invalid Input, put something else")
        break
      else
        count += 1
        if character == character.upcase && character != character.downcase
          top_row += "#{write_brail("cap")[0]}#{write_brail("cap")[1]}"
          mid_row += "#{write_brail("cap")[2]}#{write_brail("cap")[3]}"
          bot_row += "#{write_brail("cap")[4]}#{write_brail("cap")[5]}"
          count += 1
        end

        top_row += "#{write_brail(character.downcase)[0]}#{write_brail(character.downcase)[1]}"
        mid_row += "#{write_brail(character.downcase)[2]}#{write_brail(character.downcase)[3]}"
        bot_row += "#{write_brail(character.downcase)[4]}#{write_brail(character.downcase)[5]}"
        if count % 40 == 0
          braille.write("#{top_row}\n")
          braille.write("#{mid_row}\n")
          braille.write("#{bot_row}\n")
          top_row = ""
          mid_row = ""
          bot_row = ""
        end
      end
    end
      braille.write("#{top_row}\n")
      braille.write("#{mid_row}\n")
      braille.write("#{bot_row}")
    braille.close
  end

end
