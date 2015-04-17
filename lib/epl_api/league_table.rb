module EplApi
  class LeagueTable < Fetcher

    def initialize(week, options = {})
      super(options)
      @week = week
    end

    def details(force = false)
      if !@details || force
        options = {
           match_day_id: @week
        }

        @details = parse_data fetch(options, 'league-table.json')
      end

      @details
    end

    def self.parse_data(data)
      data["Data"]
    end

  end
end
