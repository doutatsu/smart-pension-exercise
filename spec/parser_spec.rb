require './parser'

RSpec.describe Parser do
  it 'initializes Parser class with provided file' do
    output = Parser.parse('file_name')

    expect(output).to eq('file_name')
  end
end
