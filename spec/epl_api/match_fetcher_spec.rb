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

  describe '#match' do
    it 'should call fetch with the given week and id, and correct data_name' do
      mf = described_class.new()
      week = 3
      id = 5
      data = double()
      allow(mf).to receive(:fetch).and_return(data)
      allow(mf).to receive(:parse_match_data)

      expect(mf).to receive(:fetch).
        with({ match_day_id: week, match_id: id }, 'match-details.json' )
      expect(mf).to receive(:parse_match_data).with(data)
      mf.match(week, id)
    end
  end

  describe '#parse_match_data' do
    it 'should return just the match data' do
      mf = described_class.new()
      match_data = double()
      data = { "Data" => match_data }

      expect(mf.parse_match_data(data)).to eq match_data
    end
  end

  describe '#match_commentary' do
    it 'should call fetch with the given week and id, and correct data_name' do
      mf = described_class.new()
      week = 3
      id = 5
      data = double()
      allow(mf).to receive(:fetch).and_return(data)
      allow(mf).to receive(:parse_commentary_data)

      expect(mf).to receive(:fetch).
        with({ match_day_id: week, match_id: id }, 'text-commentary.json' )
      expect(mf).to receive(:parse_commentary_data).with(data)
      mf.match_commentary(week, id)
    end
  end

  describe '#parse_commentary_data' do
    it 'should return the commentary data with verbose types' do
      mf = described_class.new()
      commentary_data = double()
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


      expect(mf.parse_commentary_data(data)).to eq expected_output
    end
  end

end
