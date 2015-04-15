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

    def match_commentary(week, id)
      options = {
        match_day_id: week,
        match_id: id
      }

      parse_commentary_data fetch(options, 'text-commentary.json')
    end

    def parse_commentary_data(data)
      data["Data"].map do |cd|
        comment_type_id = cd.delete("CommentTypeId")
        period_id = cd.delete("MatchPeriodId")

        cd["CommentType"] = get_type_data(
          comment_type_id, data["MetaData"]["TextCommentaryTypes"]
        )

        cd["MatchPeriod"] = get_type_data(
          period_id, data["MetaData"]["PeriodTypes"]
        )

        cd
      end
    end

    private

    def get_type_data(id, type_data)
      data = type_data.find { |td| td["TypeId"] == id }
      data.delete("FamilyType")
      data
    end

  end
end
