require_relative 'lookup_table'
class Dictionary
  include LookupTable

  attr_reader :text_input, :lookup_table, :input_braille

  def initialize(text_input)
    @text_input = split_text(text_input)
    @lookup_table = create_dictionary
    @input_braille = is_braille?(text_input)
  end

  def write_to_file
    if @input_braille
      read_characters
    else
      write_braille_to_file
    end
  end

  def split_text(input)
    text = input.split('')
    if text[-1] == "\n"
      return text[0..-2]
    end
    return text
  end

  def text_to_rows
    return_count = 0
    rows = [[],[],[]]
    @text_input.each do |letter|
      return_count += 1 if letter == "\n"
      rows[0] << letter if letter != "\n" if return_count % 3 == 0
      rows[1] << letter if letter != "\n" if return_count % 3 == 1
      rows[2] << letter if letter != "\n" if return_count % 3 == 2
    end
    # require 'pry'; binding.pry
    rows
  end

  def read_characters
    message = ""
    letter = ""
    adjustable_text_to_rows = text_to_rows
    is_cap = false
    while adjustable_text_to_rows.flatten.size != 0 do
      adjustable_text_to_rows.each do |row|
        letter << row[0]
        letter << row[1]
        row.shift(2)
      end
      if @lookup_table.key(letter) == "cap"
        is_cap = true
      elsif is_cap == true
        message << @lookup_table.key(letter).upcase
        is_cap = false
      else
        message << @lookup_table.key(letter)
      end
      letter = ""
    end
    original_message = File.open("original_message.txt", "w")
    original_message.write(message)
    original_message.close
    return message
  end

  def is_braille?(text)
    text.length == (text.count("0") + text.count(".") + text.count("\n"))
  end

  def create_r
    "0.\n00\n0."
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
    rows = ["","",""]
    count = 0
    @text_input.each do |character|
      if write_brail(character) == "Invalid Input"
        braille.write("Invalid Input, put something else")
        return "Invalid Input"
      else
        count += 1
        if character == character.upcase && character != character.downcase
          rows[0] += "#{write_brail("cap")[0]}#{write_brail("cap")[1]}"
          rows[1] += "#{write_brail("cap")[2]}#{write_brail("cap")[3]}"
          rows[2] += "#{write_brail("cap")[4]}#{write_brail("cap")[5]}"
          count += 1
        end
        rows[0] += "#{write_brail(character.downcase)[0]}#{write_brail(character.downcase)[1]}"
        rows[1] += "#{write_brail(character.downcase)[2]}#{write_brail(character.downcase)[3]}"
        rows[2] += "#{write_brail(character.downcase)[4]}#{write_brail(character.downcase)[5]}"
        if count % 40 == 0
          braille.write("#{rows[0]}\n#{rows[1]}\n#{rows[2]}\n")
          rows = ["","",""]
        end
      end
    end
    braille.write("#{rows[0]}\n#{rows[1]}\n#{rows[2]}")
    braille.close
    return rows
  end

end
