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

  end
end
