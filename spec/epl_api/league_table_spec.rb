require 'spec_helper'

describe EplApi::LeagueTable do

  describe '#details' do
    it 'should call fetch with the given week and correct data_name' do
      week = 3
      league_table = described_class.new(week)
      data = double()

      allow(league_table).to receive(:fetch).and_return(data)
      allow(league_table).to receive(:parse_data)

      expect(league_table).to receive(:fetch).
        with({ match_day_id: week }, 'league-table.json' )
      expect(league_table).to receive(:parse_data).with(data)
      league_table.details
    end
  end

  describe 'caching data' do
    it 'should return the previously fetched result' do
      week = 3
      league_table = described_class.new(week)
      data = double()

      allow(league_table).to receive(:fetch)
      allow(league_table).to receive(:parse_data).and_return(data)
      league_table.details

      expect(league_table).not_to receive(:fetch)
      league_table.details
    end

    context 'force is true' do
      it 'should refetch data' do
        week = 3
        league_table = described_class.new(week)
        data = double()

        allow(league_table).to receive(:fetch)
        allow(league_table).to receive(:parse_data).and_return(data)
        league_table.details

        expect(league_table).to receive(:fetch)
        league_table.details(true)
      end
    end
  end

  describe '::parse_data' do
    it 'should return just the league table data' do
      league_table_data = double()
      data = { "Data" => league_table_data }

      expect(described_class.parse_data(data)).to eq league_table_data
    end
  end

end
