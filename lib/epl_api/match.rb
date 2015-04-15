module EplApi
  class Match < Fetcher

    def initialize(week, id, options = {})
      super(options)
      @week = week
      @id = id
    end

    def details
      options = {
         match_day_id: @week,
         match_id: @id
      }

      self.class.parse_data fetch(options, 'match-details.json')
    end

    def commentary
      options = {
        match_day_id: @week,
        match_id: @id
      }

      self.class.parse_commentary_data fetch(options, 'text-commentary.json')
    end

    def lineups
      options = {
         match_day_id: @week,
         match_id: @id
      }

      self.class.parse_data fetch(options, 'lineups.json')
    end

    def stats
      options = {
         match_day_id: @week,
         match_id: @id
      }

      self.class.parse_data fetch(options, 'live-stats.json')
    end

    def self.all_in_week(week)
      options = {
         game_week_id: week
      }

      fetcher = self.superclass.new
      parse_week_data fetcher.fetch(options, 'scores.json')
    end

    # Parsing methods

    def self.parse_data(data)
      data["Data"]
    end

    def self.parse_week_data(data)
      data["Data"].map { |d| d["Scores"] }.flatten
    end

    def self.parse_commentary_data(data)
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

      def self.get_type_data(id, type_data)
        data = type_data.find { |td| td["TypeId"] == id }
        data.delete("FamilyType")
        data
      end

  end
end
