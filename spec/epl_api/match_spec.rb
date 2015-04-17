require 'spec_helper'

describe EplApi::Match do

  describe '#details' do
    it 'should call fetch with the given week and id, and correct data_name' do
      week = 3
      id = 5
      match = described_class.new(week, id)
      data = double()

      allow(match).to receive(:fetch).and_return(data)
      allow(described_class).to receive(:parse_data)

      expect(match).to receive(:fetch).
        with({ match_day_id: week, match_id: id }, 'match-details.json' )
      expect(described_class).to receive(:parse_data).with(data)
      match.details
    end
  end

  describe '#commentary' do
    it 'should call fetch with the given week and id, and correct data_name' do
      week = 3
      id = 5
      match = described_class.new(week, id)
      data = double()

      allow(match).to receive(:fetch).and_return(data)
      allow(match).to receive(:parse_commentary_data)

      expect(match).to receive(:fetch).
        with({ match_day_id: week, match_id: id }, 'text-commentary.json' )
      expect(described_class).to receive(:parse_commentary_data).with(data)
      match.commentary
    end
  end

  describe '#lineups' do
    it 'should call fetch with the given week and id, and correct data_name' do
      week = 3
      id = 5
      match = described_class.new(week, id)
      data = double()

      allow(match).to receive(:fetch).and_return(data)
      allow(described_class).to receive(:parse_data)

      expect(match).to receive(:fetch).
        with({ match_day_id: week, match_id: id }, 'lineups.json' )
      expect(described_class).to receive(:parse_data).with(data)
      match.lineups
    end
  end

  describe '#stats' do
    it 'should call fetch with the given week and id, and correct data_name' do
      week = 3
      id = 5
      match = described_class.new(week, id)
      data = double()

      allow(match).to receive(:fetch).and_return(data)
      allow(described_class).to receive(:parse_data)

      expect(match).to receive(:fetch).
        with({ match_day_id: week, match_id: id }, 'live-stats.json' )
      expect(described_class).to receive(:parse_data).with(data)
      match.stats
    end
  end

  describe 'caching data' do
    it 'should return the previously fetched result' do
      week = 3
      id = 5
      match = described_class.new(week, id)
      data = double()

      allow(match).to receive(:fetch)
      allow(described_class).to receive(:parse_data).and_return(data)
      match.details

      expect(match).not_to receive(:fetch)
      match.details
    end

    context 'force is true' do
      it 'should refetch data' do
        week = 3
        id = 5
        match = described_class.new(week, id)
        data = double()

        allow(match).to receive(:fetch)
        allow(described_class).to receive(:parse_data).and_return(data)
        match.details

        expect(match).to receive(:fetch)
        match.details(true)
      end
    end
  end

  describe '::all_in_week' do
    it 'should call fetch with the given week and correct data_name' do
      fetcher = instance_double('EplApi::Fetcher')
      week = 3
      data = double()

      allow(described_class.superclass).to receive(:new).and_return(fetcher)
      allow(fetcher).to receive(:fetch).and_return(data)
      allow(described_class).to receive(:parse_week_data)

      expect(fetcher).to receive(:fetch).
        with({ game_week_id: week }, 'scores.json' )
      expect(described_class).to receive(:parse_week_data).with(data)
      described_class.all_in_week(week)
    end
  end

  describe '::parse_week_data' do
    it 'should return a single array of matches' do
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
      expect(described_class.parse_week_data(data)).to eq expected_output
    end
  end


  describe '::parse_data' do
    it 'should return just the match data' do
      expected_data = double()
      data = { "Data" => expected_data }

      expect(described_class.parse_data(data)).to eq expected_data
    end
  end

  describe '::parse_commentary_data' do
    it 'should return the commentary data with verbose types' do
      data = {
        "Data" => [
          { "CommentTypeId" => 1, "MatchPeriodId" => 1 },
          { "CommentTypeId" => 2, "MatchPeriodId" => 2 }
        ],
        "MetaData" => {
          "TextCommentaryTypes" => [
            {
              "FamilyType" => "TextCommentaryTypes",
              "TypeId" => 1,
              "Name" => "Goal",
              "Code" => "",
              "Description" => "Goal"
            },
            {
              "FamilyType" => "TextCommentaryTypes",
              "TypeId" => 2,
              "Name" => "Miss",
              "Code" => "",
              "Description" => "Shoot off target"
            }
          ],
          "PeriodTypes" => [
            {
              "FamilyType" => "PeriodTypes",
              "TypeId" => 1,
              "Name" => "FirstHalf",
              "Code" => "FH",
              "Description" => "First Half"
            },
            {
              "FamilyType" => "PeriodTypes",
              "TypeId" => 2,
              "Name" => "SecondHalf",
              "Code" => "SH",
              "Description" => "Second Half"
            }
          ]
        }
      }

      expected_output = [
        {
          "CommentType" => {
            "TypeId" => 1,
            "Name" => "Goal",
            "Code" => "",
            "Description" => "Goal"
          },
          "MatchPeriod" => {
            "TypeId" => 1,
            "Name" => "FirstHalf",
            "Code" => "FH",
            "Description" => "First Half"
          }
        },
        {
          "CommentType" => {
            "TypeId" => 2,
            "Name" => "Miss",
            "Code" => "",
            "Description" => "Shoot off target"
          },
          "MatchPeriod" => {
            "TypeId" => 2,
            "Name" => "SecondHalf",
            "Code" => "SH",
            "Description" => "Second Half"
          }
        }
      ]


      expect(described_class.parse_commentary_data(data)).to eq expected_output
    end
  end

end
