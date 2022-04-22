if ARGV.length != 2
  puts 'wrong number of arguments'
  exit
end

file_name_1 = ARGV[0]
file_name_2 = ARGV[1]

message = File.open(file_name_1, "r")
braille = File.open(file_name_2, "w")

text_array = message.readlines
text = text_array.join
character_count = text.length - 1 #included the minus 1, because it has 2 lines


puts "Created '#{ARGV[1]}' containing #{character_count} characters"


# puts "..\n00\n.."
# puts '..\n00\n..'
require 'pry'; binding.pry

braille.write(text)
braille.close

require 'pry'; binding.pry
# require 'pry'; binding.pry
# text.each do |letter|
#
# end
