# require 'file'

if ARGV.length != 2
  puts 'wrong number of arguments'
  exit
end



file_name_1 = ARGV[0]
file_name_2 = ARGV[1]

message = File.open(file_name_1, "r")
# file = File.open(file_name_1)
# File.open(<filename>, "w")

# puts "Working on #{ARGV}"

text_array = message.readlines
character_count = text_array.join.length - 1


puts "Created '#{ARGV[1]}' containing #{character_count} characters"

require 'pry'; binding.pry
