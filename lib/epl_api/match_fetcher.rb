module EplApi
  class MatchFetcher < Fetcher

    def week_matches(week)
      options = {
         game_week_id: week
      }

      parse_week_data fetch(options, 'scores.json')
    end

    def parse_week_data(data)
      data["Data"].map { |d| d["Scores"] }.flatten
    end

    def match(week, id)
      options = {
         match_day_id: week,
         match_id: id
      }

      parse_match_data fetch(options, 'match-details.json')
    end

    def parse_match_data(data)
      data["Data"]
    end

  end
end
