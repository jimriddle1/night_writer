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
    dictionary = Dictionary.new("Braille")
    expect(dictionary.lookup_table["r"]).to eq("0.\n00\n0.")
  end

  it 'can read a letter in and output the brail' do
    dictionary = Dictionary.new("braille")
    expect(dictionary.write('~')). to eq("Invalid Input")
    expect(dictionary.write('r')). to eq("0.\n00\n0.")
  end

  it 'can populate all 26 lower case letters and have a space' do
    dictionary = Dictionary.new("braille")
    expect(dictionary.lookup_table.count).to eq(27)
  end

  it 'can verify uniquness and length of each braille character' do
    dictionary = Dictionary.new("braille")
    expect(dictionary.lookup_table.values.uniq.count).to eq(dictionary.lookup_table.values.count)

    array = dictionary.lookup_table.values
    correct_length = 8
    place_holder = array.select do |letter|
      letter.length != correct_length
    end

    expect(place_holder.count).to eq(0)
  end

  it 'can write one character to a file' do
    dictionary = Dictionary.new("h")
    dictionary.write_to_file
    # require 'pry'; binding.pry
    expect(File.size("braille_test.txt")).to eq(8)
  end
end
