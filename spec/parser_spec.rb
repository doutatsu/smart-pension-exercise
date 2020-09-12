require './parser'

RSpec.describe Parser do
  it 'initializes Parser class with provided file' do
    output = Parser.parse('webserver.log')

    expect(output).to include(
      {
        '016.464.657.359' => {
          '/about' => 5,
          '/about/2' => 5,
          '/contact' => 2,
          '/help_page/1' => 4,
          '/home' => 3,
          '/index' => 3
        }
      }
    )
  end
end
