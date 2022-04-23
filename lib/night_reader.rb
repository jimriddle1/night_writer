require "./lib/dictionary"

if ARGV.length != 2
  puts 'wrong number of arguments'
  exit
end

message = File.open(ARGV[0], "r")
braille = File.open(ARGV[1], "w")

text = message.readlines.join
character_count = text.length - 1


dictionary = Dictionary.new(text)

# require "pry"; binding.pry

puts "Created '#{ARGV[1]}' containing #{character_count} characters"

dictionary.read_characters
braille.close


# ruby lib/night_reader.rb braille.txt original_message.txt


# 0.
# 00
# ..
