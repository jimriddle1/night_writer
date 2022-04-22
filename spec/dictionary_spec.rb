require 'simplecov'
SimpleCov.start

require './lib/dictionary'

RSpec.describe Dictionary do

  it 'exists' do
    dictionary = Dictionary.new("Braille")
    expect(dictionary).to be_an_instance_of(Dictionary)
  end

  it 'has readable attrs' do
    dictionary = Dictionary.new("Braille")
    expect(dictionary.name).to eq("Braille")
  end

  it 'can create an r' do
    dictionary = Dictionary.new("Braille")
    expect(dictionary.create_r).to eq(".0\n..\n.0")
  end

  it 'can read a letter in and output the brail' do
    dictionary = Dictionary.new("Braille")
    expect(dictionary.write('~')). to eq("Invalid Input")
    expect(dictionary.write('r')). to eq(".0\n..\n.0")
  end

end
