require 'spec_helper'

describe EplApi::LeagueTableFetcher do

  describe '#league_table' do
    it 'should call fetch with the given week and correct data_name' do
      ltf = described_class.new()
      week = 3
      data = double()
      allow(ltf).to receive(:fetch).and_return(data)
      allow(ltf).to receive(:parse_data)

      expect(ltf).to receive(:fetch).
        with({ match_day_id: week }, 'league-table.json' )
      expect(ltf).to receive(:parse_data).with(data)
      ltf.league_table(week: week)
    end
  end

  describe '#parse_data' do
    it 'should return just the league table data' do
      ltf = described_class.new()
      league_table_data = double()
      data = { "Data" => league_table_data }

      expect(ltf.parse_data(data)).to eq league_table_data
    end
  end

end
