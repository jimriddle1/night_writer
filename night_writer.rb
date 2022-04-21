if ARGV.length < 2
  puts "Too few arguments"
  exit
end

require 'pry'; binding.pry

puts "Working on #{ARGV}"
