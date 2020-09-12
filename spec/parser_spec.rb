require './parser'

RSpec.describe Parser do
  describe 'when file is provied' do
    it 'returns list of webpages with most page views ordered from most to least visited' do
      output = Parser.parse('webserver.log')

      expect(output).to match_array(
        [
          '/about/2 90 visits',
          '/contact 89 visits',
          '/index 82 visits',
          '/about 81 visits',
          '/help_page/1 80 visits',
          '/home 78 visits'
        ]
      )
    end
  end
end
