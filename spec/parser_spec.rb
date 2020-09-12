require './parser'

RSpec.describe Parser do
  describe 'when file is provied' do
    it 'returns list of webpages with most unique page views, ordered from most to least visited' do
      output = Parser.parse('webserver.log')

      expect(output).to match_array(
        [
          '/help_page/1 7 unique visits',
          '/contact 4 unique visits',
          '/about 4 unique visits',
          '/home 4 unique visits',
          '/about/2 3 unique visits',
          '/index 1 unique visits'
        ]
      )
    end

    describe 'and mode is most_visited' do
      it 'returns list of webpages with most page views ordered from most to least visited' do
        output = Parser.parse('webserver.log', mode: :most_visited)

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
end
