require 'spec_helper'

describe EplApi::LeagueTable do

  describe '#details' do
    it 'should call fetch with the given week and correct data_name' do
      league_table = described_class.new()
      week = 3
      data = double()
      allow(league_table).to receive(:fetch).and_return(data)
      allow(league_table).to receive(:parse_data)

      expect(league_table).to receive(:fetch).
        with({ match_day_id: week }, 'league-table.json' )
      expect(league_table).to receive(:parse_data).with(data)
      league_table.details(week: week)
    end
  end

  describe '#parse_data' do
    it 'should return just the league table data' do
      league_table = described_class.new()
      league_table_data = double()
      data = { "Data" => league_table_data }

      expect(league_table.parse_data(data)).to eq league_table_data
    end
  end

end
