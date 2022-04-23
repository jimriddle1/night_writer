require "./lib/dictionary"

if ARGV.length != 2
  puts 'wrong number of arguments'
  exit
end

message = File.open(ARGV[0], "r")
braille = File.open(ARGV[1], "w")

text = message.readlines.join
character_count = text.length - 1 #included the minus 1, because it has 2 lines


dictionary = Dictionary.new(text)

# require "pry"; binding.pry
puts "Created '#{ARGV[1]}' containing #{character_count} characters"

dictionary.write_braille_to_file
braille.close


# ruby lib/night_writer.rb message.txt braille.txt


# 0.
# 00
# ..


# @text_input=["0", ".", "\n", "0", "0", "\n", ".", "."]>
# @text_input=["0", ".", "0", "0", "\n", "0", "0", ".", ".", "\n", ".", ".", "0", "."]>
