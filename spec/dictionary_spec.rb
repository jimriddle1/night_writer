require 'simplecov'
SimpleCov.start

require './lib/dictionary'

RSpec.describe Dictionary do

  it 'exists' do
    dictionary = Dictionary.new("hello")
    expect(dictionary).to be_an_instance_of(Dictionary)
  end

  it 'can take the input as text and split it up' do
    dictionary = Dictionary.new("hello")
    expect(dicitonary.text_input).to eq(['h','e','l','l','o'])
  end

  it 'has readable attrs' do
    dictionary = Dictionary.new("Braille")
    expect(dictionary.name).to eq("Braille")
  end

  it 'can create an r' do
    dictionary = Dictionary.new("Braille")
    expect(dictionary.create_r).to eq(".0\n..\n.0")
  end

  it 'can populate the dictionary' do
    dictionary = Dictionary.new("Braille")
    # require 'pry'; binding.pry
    expect(dictionary.lookup_table["r"]).to eq(".0\n..\n.0")
  end

  it 'can read a letter in and output the brail' do
    dictionary = Dictionary.new("Braille")
    expect(dictionary.write('~')). to eq("Invalid Input")
    expect(dictionary.write('r')). to eq(".0\n..\n.0")
  end

end
