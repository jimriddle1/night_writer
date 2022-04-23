require "./lib/dictionary"

if ARGV.length != 2
  puts 'wrong number of arguments'
  exit
end

message = File.open(ARGV[0], "r")
braille = File.open(ARGV[1], "w")

text = message.readlines.join
character_count = text.length - 1 #included the minus 1, because it has 2 lines

require "pry"; binding.pry

dictionary = Dictionary.new(text)

puts "Created '#{ARGV[1]}' containing #{character_count} characters"

dictionary.write_to_file
braille.close


# ruby lib/night_writer.rb message.txt braille.txt


# 0.
# 00
# ..
