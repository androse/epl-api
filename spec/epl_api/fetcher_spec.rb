require 'spec_helper'

describe EplApi::Fetcher do

  describe '#fetch' do
    it 'should call get with the formatted url' do
      fetcher = described_class.new()
      options = double()
      data_name = double()
      formatted_url = 'http://example.com'

      allow(fetcher).to receive(:format_url).
        with(options, data_name).and_return(formatted_url)

      allow(EplApi::HttpClient).to receive(:get)
      expect(EplApi::HttpClient).to receive(:get).with(formatted_url)
      fetcher.fetch(options, data_name)
    end
  end

  describe '#format_url' do
    it 'should format the url given a data name' do
      fetcher = described_class.new()
      options = double()
      data_name = 'data.json'
      formatted_options = 'competionId=8'

      allow(fetcher).to receive(:format_options).
        with(options).and_return(formatted_options)

      expected_output = "#{fetcher.base_url}/#{formatted_options}/#{data_name}"
      expect(fetcher.format_url(options, data_name)).to eq expected_output
    end
  end

  describe '#format_options' do
    it 'should format options into an endpoints string' do
      fetcher = described_class.new(competition_id: 8, season_id: 2014)
      options = {
        match_day_id: 1,
        match_id: 2
      }

      expected_output = 'competitionId=8/seasonId=2014/matchDayId=1/matchId=2'
      expect(fetcher.format_options(options)).to eq expected_output
    end
  end

end
