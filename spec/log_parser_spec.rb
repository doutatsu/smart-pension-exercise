require './log_parser'

RSpec.describe LogParser do
  describe 'when file is provided' do
    describe 'and mode is most_unique_visited' do
      it 'returns list of webpages with most unique page views, ordered from most to least visited' do
        output = described_class.parse('webserver.log', :most_unique_visited)

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
    end

    describe 'and mode is most_visited' do
      it 'returns list of webpages with most page views ordered from most to least visited' do
        output = described_class.parse('webserver.log', :most_visited)

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

    describe 'and mode is visits_per_ip' do
      it 'returns visited pages per IP' do
        output = described_class.parse('webserver.log', :visits_per_ip)
        expected_string = '[126.318.035.038] /help_page/1 | 4 unique visits |'\
        ' /index | 4 unique visits | /about | 3 unique visits | /contact |'\
        ' 3 unique visits | /home | 3 unique visits | /about/2 | 1 unique visits'

        expect(output).to include(expected_string)
      end
    end

    describe 'and mode provided does not exist' do
      it 'raises Incorrect mode provided Runtime error' do
        expect { described_class.parse('webserver.log', :test) }.to raise_error(
          RuntimeError, 'Incorrect mode provided'
        )
      end
    end
  end
end
