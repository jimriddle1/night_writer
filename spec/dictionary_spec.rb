require 'simplecov'
SimpleCov.start

require './lib/dictionary'

RSpec.describe Dictionary do

  it 'exists' do
    dictionary = Dictionary.new("hello")
    expect(dictionary).to be_an_instance_of(Dictionary)
  end

  it 'has readable attrs' do
    dictionary = Dictionary.new("hello")
    expect(dictionary.text_input).to be_an_instance_of(Array)
  end

  it 'can take the input as text and split it up' do
    dictionary = Dictionary.new("hello")
    expect(dictionary.text_input).to eq(['h','e','l','l','o'])
  end

  it 'can create an r' do
    dictionary = Dictionary.new("braille")
    expect(dictionary.create_r).to eq("0.\n00\n0.")
  end

  it 'can populate the dictionary' do
    dictionary = Dictionary.new("braille")
    expect(dictionary.lookup_table["r"]).to eq("0.000.")
  end

  it 'can read a letter in and output the brail' do
    dictionary = Dictionary.new("braille")
    expect(dictionary.write('~')). to eq("Invalid Input")
    expect(dictionary.write('r')). to eq("0.000.")
  end

  it 'can populate all 26 lower case letters and have a space' do
    dictionary = Dictionary.new("braille")
    expect(dictionary.lookup_table.count).to eq(27)
  end

  it 'can verify uniquness and length of each braille character' do
    dictionary = Dictionary.new("braille")
    expect(dictionary.lookup_table.values.uniq.count).to eq(dictionary.lookup_table.values.count)

    array = dictionary.lookup_table.values
    correct_length = 6
    place_holder = array.select do |letter|
      letter.length != correct_length
    end

    expect(place_holder.count).to eq(0)
  end

  it 'can write one character to a file' do
    dictionary = Dictionary.new("h")
    dictionary.write_braille_to_file
    # require 'pry'; binding.pry
    expect(File.size("braille.txt")).to eq(8)
  end

  it 'can know when the input has a line break vs. not' do
    dictionary = Dictionary.new("hello")
    dictionary_2 = Dictionary.new("hello\n")
    expect(dictionary.text_input).to eq(dictionary_2.text_input)
  end

  it 'can know when the braille input has a line break at the end vs. not' do
    dictionary = Dictionary.new("0.\n00\n..")
    dictionary_2 = Dictionary.new("0.\n00\n..\n")
    expect(dictionary.text_input).to eq(dictionary_2.text_input)
  end

  it 'can write multiple characters to the main file' do
    dictionary = Dictionary.new("hello world")
    dictionary.write_braille_to_file
    # 11 characters times 6 plus 2 line indentations equals 69
    expect(File.size("braille.txt")).to eq(68)
  end

  it 'can write a new line indentation' do
    dictionary = Dictionary.new("aaaabbbbccccddddeeeeffffgggghhhhiiiijjjjk")
    dictionary.write_braille_to_file
    # 41 characters * 6 plus 5 (3 for new line, 2 for second) line indentations = 251
    expect(File.size("braille.txt")).to eq(251)
  end

  it 'my split text method can handle braille / not braille' do
    dictionary = Dictionary.new("hello world")
    expect(dictionary.split_text("abc")).to eq(['a','b','c'])
    expect(dictionary.split_text("0.\n00\n0.")).to eq(["0", ".", "\n", "0", "0", "\n", "0", "."])
    expected = ["0", ".", "0", ".", "0", "0", ".", ".", "\n", "0", "0", "0", "0", ".", ".", "0", "0", "\n",
      ".", ".", "0", ".", "0", ".", "0", ".", "\n", "0", ".", "\n", ".", ".", "\n", ".", "0"]
    expect(dictionary.split_text("0.0.00..\n0000..00\n..0.0.0.\n0.\n..\n.0")).to eq(expected)
  end

  it 'can check if the input is braille or not' do
    dictionary = Dictionary.new("hello world")
    expect(dictionary.is_braille?("abc")).to eq(false)
    expect(dictionary.is_braille?("abc\ndef")).to eq(false)
    expect(dictionary.is_braille?("0.\n00\n0.")).to eq(true)
    expect(dictionary.is_braille?("0.0.00..\n0000..00\n..0.0.0.\n0.\n..\n.0")).to eq(true)
  end

  it 'can split up my braille input into an array of top mid bot row' do
    dictionary = Dictionary.new("0.\n00\n0.")
    # expected = [['0.'],['00'],['0.']]
    expect(dictionary.text_to_rows).to eq([['0','.'],['0','0'],['0','.']])
  end

  it 'can take the rows of text and give me a letter' do
    dictionary = Dictionary.new("0.\n00\n..")
    expect(dictionary.rows_to_character).to eq('h')
  end

  it 'can convert multiple braille characters to letters' do
    dictionary = Dictionary.new("0.0.\n0000\n..0.\n")
    expect(dictionary.read_characters).to eq('hr')
  end

  it 'can handle two braille characters on different rows' do
    # dictionary = Dictionary.new("0.0.0.0.0....00..0.0...0.0..0...0.0.00000.0...000..0.00.000...000.0...000.0.00.0\n00.00.0..0..00000.0...0.0.......0..0.000.000.....00.0...00.0..0..000..0.00....00\n....0.0.0...0.....0.....0.......0.0.0.....0...0...0.0...........0.0...0.0.....0.\n.0000...000.0.000..00..0\n0....0..0...000..00..00.\n........0.000.0.0.0...0.")
    dictionary = Dictionary.new("..\n..\n..\n0.\n00\n0.")
    # dictionary = Dictionary.new("ab\ncd\nef\nhi\njk\n0.\n")
    # require "pry"; binding.pry
    expect(dictionary.read_characters).to eq(' r')

  end

  it 'can convert multiple braille when the lines are longer than 40 chars' do
    dictionary = Dictionary.new("0.0.0.0.0....00..0.0...0.0..0...0.0.00000.0...000..0.00.000...000.0...000.0.00.0\n00.00.0..0..00000.0...0.0.......0..0.000.000.....00.0...00.0..0..000..0.00....00\n....0.0.0...0.....0.....0.......0.0.0.....0...0...0.0...........0.0...0.0.....0.\n.0000...000.0.000..00..0\n0....0..0...000..00..00.\n........0.000.0.0.0...0.")
    # dictionary = Dictionary.new("..\n..\n..\n0.\n00\n0.")
    # dictionary = Dictionary.new("ab\ncd\nef\nhi\njk\n0.\n")
    # require "pry"; binding.pry
    expect(dictionary.read_characters).to eq('hello this is a longer message for practice purposes')

  end

end
