module EplApi
  class LeagueTable < Fetcher

    def details(options = {})
      # 38th (last) week will always return the current league table
      options = {
         match_day_id: options[:week] || 38
      }

      parse_data fetch(options, 'league-table.json')
    end

    def parse_data(data)
      data["Data"]
    end

  end
end
