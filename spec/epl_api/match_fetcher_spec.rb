require 'spec_helper'

describe EplApi::MatchFetcher do

  describe '#week_matches' do
    it 'should call fetch with the given week and correct data_name' do
      mf = described_class.new()
      week = 3
      data = double()
      allow(mf).to receive(:fetch).and_return(data)
      allow(mf).to receive(:parse_week_data)

      expect(mf).to receive(:fetch).
        with({ game_week_id: week }, 'scores.json' )
      expect(mf).to receive(:parse_week_data).with(data)
      mf.week_matches(week)
    end
  end

  describe '#parse_week_data' do
    it 'should return a single array of matches' do
      mf = described_class.new()
      day1_data = double()
      day2_data = double()
      day3_data = double()
      data = {
        "Data" => [
          { "Scores" => [day1_data] },
          { "Scores" => [day2_data] },
          { "Scores" => [day3_data] }
        ]
      }

      expected_output = [day1_data, day2_data, day3_data]
      expect(mf.parse_week_data(data)).to eq expected_output
    end
  end

end
